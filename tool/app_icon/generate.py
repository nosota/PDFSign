#!/usr/bin/env python3
"""Builds the application icon for every place that needs one.

Run from the repository root:

    python3 tool/app_icon/generate.py

Writes:
  tool/app_icon/app_icon_1024.png                     the master, with alpha
  macos/Runner/Assets.xcassets/AppIcon.appiconset/    seven sizes Xcode packs
  windows/runner/resources/app_icon.ico               seven sizes in one file
  assets/images/app_icon.png                          the Welcome screen logo

The artwork is a white page on a rounded blue square. The signature on the
page is lifted out of `pSGNF.jpg`, the drawing this icon came from; the page,
its folded corner and the text lines are drawn here, because the original is
an illustration and its detail turns to mush below 64 px.

Requires Pillow.
"""

from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter

ROOT = Path(__file__).resolve().parents[2]
SOURCE = ROOT / "pSGNF.jpg"
HERE = Path(__file__).resolve().parent

# The app's own accent, `AppColors.primary`, top to bottom.
GRADIENT_TOP = (0x2B, 0x7C, 0xFF)
GRADIENT_BOTTOM = (0x00, 0x3D, 0x99)

# Apple's icon grid: the rounded square sits inside a margin, and its corner
# radius is a fixed share of its side.
MARGIN_RATIO = 0.098
CORNER_RATIO = 0.2246

# The page, as a share of the rounded square.
PAGE_WIDTH_RATIO = 0.56
PAGE_ASPECT = 1.28
FOLD_RATIO = 0.26

# Below this, the text lines are left out: they merge into a smudge and cost
# more than they give.
LINES_FROM = 64

MACOS_SIZES = (16, 32, 64, 128, 256, 512, 1024)
WINDOWS_SIZES = (16, 24, 32, 48, 64, 128, 256)

# Where the signature sits in the source image.
SIGNATURE_BOX = (300, 940, 860, 1190)


def signature() -> Image.Image:
    """Lifts the signature out of the source by how dark it is.

    The source has no alpha, so the ink is separated from the paper by
    luminance, with a soft ramp so the stroke keeps its edges.
    """
    ink = Image.open(SOURCE).convert("RGB").crop(SIGNATURE_BOX)
    width, height = ink.size
    out = Image.new("RGBA", (width, height), (0, 0, 0, 0))
    src, dst = ink.load(), out.load()

    for y in range(height):
        for x in range(width):
            r, g, b = src[x, y]
            luminance = (r + g + b) / 3
            if luminance < 235:
                alpha = round(max(0, min(255, (235 - luminance) / 175 * 255)))
                dst[x, y] = (26, 26, 26, alpha)
    return out


def rounded_mask(size: int) -> Image.Image:
    """An antialiased rounded-square silhouette."""
    scale = 4
    mask = Image.new("L", (size * scale, size * scale), 0)
    ImageDraw.Draw(mask).rounded_rectangle(
        [0, 0, size * scale - 1, size * scale - 1],
        radius=round(size * scale * CORNER_RATIO),
        fill=255,
    )
    return mask.resize((size, size), Image.LANCZOS)


def gradient(size: int) -> Image.Image:
    column = Image.new("RGB", (1, size))
    for y in range(size):
        t = y / max(1, size - 1)
        column.putpixel(
            (0, y),
            tuple(
                round(GRADIENT_TOP[i] + (GRADIENT_BOTTOM[i] - GRADIENT_TOP[i]) * t)
                for i in range(3)
            ),
        )
    return column.resize((size, size), Image.BILINEAR)


def page(width: int, height: int, fold: int) -> Image.Image:
    """A white page with its top-right corner turned down."""
    scale = 3
    w, h, f = width * scale, height * scale, fold * scale
    img = Image.new("RGBA", (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    draw.rounded_rectangle([0, 0, w - 1, h - 1], radius=round(w * 0.10),
                           fill=(255, 255, 255, 255))
    # Cut the corner away, then lay the fold back over the hole.
    draw.polygon([(w - f, 0), (w, 0), (w, f)], fill=(0, 0, 0, 0))
    draw.polygon([(w - f, 0), (w, f), (w - f, f)], fill=(236, 238, 242, 255))

    return img.resize((width, height), Image.LANCZOS)


def build(size: int, ink: Image.Image) -> Image.Image:
    canvas = Image.new("RGBA", (size, size), (0, 0, 0, 0))

    inset = round(size * MARGIN_RATIO)
    side = size - inset * 2
    background = gradient(side).convert("RGBA")
    background.putalpha(rounded_mask(side))
    canvas.paste(background, (inset, inset), background)

    page_width = round(side * PAGE_WIDTH_RATIO)
    page_height = round(page_width * PAGE_ASPECT)
    sheet = page(page_width, page_height, round(page_width * FOLD_RATIO))
    x = inset + (side - page_width) // 2
    y = inset + (side - page_height) // 2

    shadow = Image.new("RGBA", canvas.size, (0, 0, 0, 0))
    shadow.paste(sheet, (x, y + round(size * 0.012)), sheet)
    canvas = Image.alpha_composite(
        canvas, shadow.filter(ImageFilter.GaussianBlur(size * 0.016))
    )
    canvas.paste(sheet, (x, y), sheet)

    if size >= LINES_FROM:
        draw = ImageDraw.Draw(canvas)
        thickness = max(2, round(page_width * 0.045))
        for i in range(3):
            top = y + round(page_height * 0.24) + i * round(page_height * 0.11)
            draw.rounded_rectangle(
                [
                    x + round(page_width * 0.16),
                    top,
                    x + round(page_width * 0.66),
                    top + thickness,
                ],
                radius=thickness // 2,
                fill=(150, 152, 158, 255),
            )

    ink_width = round(page_width * 0.74)
    ink_height = round(ink_width * ink.size[1] / ink.size[0])
    canvas.paste(
        ink.resize((ink_width, ink_height), Image.LANCZOS),
        (x + (page_width - ink_width) // 2, y + round(page_height * 0.60)),
        ink.resize((ink_width, ink_height), Image.LANCZOS),
    )

    return canvas


def main() -> None:
    ink = signature()

    master = build(1024, ink)
    master.save(HERE / "app_icon_1024.png")

    appiconset = ROOT / "macos/Runner/Assets.xcassets/AppIcon.appiconset"
    for size in MACOS_SIZES:
        build(size, ink).save(appiconset / f"app_icon_{size}.png")

    # Each size is drawn rather than scaled from the master: the text lines
    # are left out below 64 px, which a resize could not decide.
    windows = [build(size, ink) for size in WINDOWS_SIZES]
    windows[-1].save(
        ROOT / "windows/runner/resources/app_icon.ico",
        format="ICO",
        sizes=[(s, s) for s in WINDOWS_SIZES],
        append_images=windows[:-1],
    )

    # The Welcome screen draws this at 80 pt; 256 keeps it crisp on retina.
    build(256, ink).save(ROOT / "assets/images/app_icon.png")

    print(f"master      {HERE / 'app_icon_1024.png'}")
    print(f"macOS       {len(MACOS_SIZES)} sizes in {appiconset}")
    print(f"Windows     {len(WINDOWS_SIZES)} sizes in app_icon.ico")
    print("Welcome     assets/images/app_icon.png")


if __name__ == "__main__":
    main()
