/// How large a document may be before its memory is worth caring about.
///
/// Two decisions share this number, which is why it lives here rather than in
/// either of them. Below it, the original bytes a save starts from are kept in
/// memory; above it they are copied to a temporary file instead. A protected
/// document has no such choice — it cannot be read from the file as it stands
/// — so a large one is held in memory whatever this says, and the reader is
/// told about it.
const documentMemoryThresholdBytes = 50 * 1024 * 1024; // 50 MB
