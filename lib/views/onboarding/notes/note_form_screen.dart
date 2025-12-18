import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/note_model.dart';
import '../../../providers/note_provider.dart';

class NoteFormScreen extends StatefulWidget {
  final Note? note; // Nullable untuk mode Tambah, non-null untuk mode Edit

  const NoteFormScreen({super.key, this.note});

  @override
  State<NoteFormScreen> createState() => _NoteFormScreenState();
}

class _NoteFormScreenState extends State<NoteFormScreen> {
  final _formKey = GlobalKey<FormState>(); // Key untuk Form
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  String _selectedCategory = 'Pekerjaan'; // Default Category

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(
      text: widget.note?.content ?? '',
    );
    _selectedCategory = widget.note?.category ?? 'Pekerjaan';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  // Fungsi CREATE dan UPDATE
  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      final noteProvider = Provider.of<NoteProvider>(context, listen: false);

      if (widget.note == null) {
        // CRUD - CREATE (Tambah Catatan)
        noteProvider.addNote(
          _titleController.text,
          _contentController.text,
          _selectedCategory,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Catatan baru berhasil ditambahkan!')),
        );
      } else {
        // CRUD - UPDATE (Edit Catatan)
        noteProvider.updateNote(
          widget.note!.id,
          _titleController.text,
          _contentController.text,
          _selectedCategory,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Catatan berhasil diperbarui!')),
        );
      }
      Navigator.pop(context);
    }
    // Jika validasi gagal, pesan error akan muncul di bawah TextFormField (Wajib UAS)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.note == null ? 'Tambah Catatan Baru' : 'Edit Catatan',
        ),
        actions: [
          IconButton(icon: const Icon(Icons.check), onPressed: _saveNote),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          // Form (Wajib UAS)
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // TextFormField Judul
              TextFormField(
                // TextFormField (Wajib UAS)
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Judul',
                  hintText: 'Judul Catatan di sini', // Sesuai screenshot
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul tidak boleh kosong'; // Error Handling Form (Wajib UAS)
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // TextFormField Konten
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Isi Catatan',
                  hintText: 'Tulis Catatan di sini',
                ),
                maxLines: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Isi catatan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Dropdown Kategori
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: const InputDecoration(labelText: 'Kategori'),
                items: ['Pekerjaan', 'Rumah', 'Belanja', 'Sekolah', 'Lainnya']
                    .map(
                      (label) =>
                          DropdownMenuItem(value: label, child: Text(label)),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
