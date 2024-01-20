abstract class UndoableCommand {
  void execute();
  void undo();
  void redo();
}