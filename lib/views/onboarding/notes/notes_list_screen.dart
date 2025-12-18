import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/note_provider.dart';
import 'note_form_screen.dart'; // Import halaman form

class NotesListScreen extends StatelessWidget {
  const NotesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Semua Catatan')),
      // Consumer untuk membaca state dari Provider
      body: Consumer<NoteProvider>(
        builder: (context, noteProvider, child) {
          // 1. Loading Indicator (Wajib UAS)
          if (noteProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.pink),
            );
          }

          // 2. Tampilan Data Kosong (Wajib UAS)
          if (noteProvider.notes.isEmpty) {
            return const Center(
              child: Text(
                'Anda belum memiliki catatan. Ketuk + untuk menambah!',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          // 3. Menampilkan Daftar Catatan
          return ListView.builder(
            // ListView.builder (Wajib UAS)
            itemCount: noteProvider.notes.length,
            itemBuilder: (context, index) {
              final note = noteProvider.notes[index];
              return Card(
                color: Theme.of(
                  context,
                ).colorScheme.secondary.withOpacity(0.2), // Pink aksen
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: ListTile(
                  title: Text(
                    note.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    note.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.pink),
                    onPressed: () {
                      // CRUD - DELETE
                      noteProvider.deleteNote(note.id);
                      // SnackBar (Wajib UAS)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Catatan dihapus!')),
                      );
                    },
                  ),
                  onTap: () {
                    // Navigasi ke Halaman Form untuk EDIT
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteFormScreen(note: note),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
