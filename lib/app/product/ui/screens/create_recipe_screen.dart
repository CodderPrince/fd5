// lib/app/product/ui/screens/create_recipe_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../../../app/shared/data/controllers/actions/jump_action.dart';
import '../../../../app/data/models/recipe.dart'; // <<< Updated import

class CreateRecipeScreen extends StatefulWidget {
  const CreateRecipeScreen({super.key});

  @override
  State<CreateRecipeScreen> createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _cookingTimeController = TextEditingController();
  final TextEditingController _servingSizeController = TextEditingController();
  String? _selectedCategoryName; // Renamed for clarity

  final List<String> _recipeCategories = [
    'Breakfast', 'Lunch', 'Dinner', 'Dessert', 'Snack', 'Vegan', 'Meat', 'Drinks',
    'Soups', 'Salads', 'Pasta', 'Chocolate', 'Healthy', 'Western',
  ];

  File? _pickedImage;
  String? _imageUrl;
  bool _isUploadingImage = false;

  // Temporary mapping for category name to ID (you might fetch this from DB)
  int? _getCategoryIdFromName(String? categoryName) {
    if (categoryName == null) return null;
    switch (categoryName) {
      case 'Breakfast': return 3;
      case 'Lunch': return 7;
      case 'Dinner': return 2;
      case 'Dessert': return 8;
    // ... map other categories ...
      default: return null; // Or a default 'Other' category ID
    }
  }

  @override
  void dispose() {
    _recipeNameController.dispose();
    _descriptionController.dispose();
    _cookingTimeController.dispose();
    _servingSizeController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
        _imageUrl = null;
        _isUploadingImage = true;
      });
      await _uploadImageToSupabase();
    }
  }

  Future<void> _uploadImageToSupabase() async {
    if (_pickedImage == null) return;

    final supabase = Supabase.instance.client;
    const bucketName = 'recipe_images';

    try {
      final String uniqueFileName = 'recipe_${const Uuid().v4()}${_pickedImage!.path.substring(_pickedImage!.path.lastIndexOf('.'))}';
      await supabase.storage.from(bucketName).upload(
        uniqueFileName,
        _pickedImage!,
        fileOptions: const FileOptions(
          cacheControl: '3600',
          upsert: false,
        ),
      );

      final String publicUrl = supabase.storage.from(bucketName).getPublicUrl(uniqueFileName);

      setState(() {
        _imageUrl = publicUrl;
        _isUploadingImage = false;
      });

      Get.snackbar(
        'Success',
        'Image uploaded successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

    } on StorageException catch (e) {
      setState(() {
        _isUploadingImage = false;
        _pickedImage = null;
      });
      Get.snackbar(
        'Upload Failed',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      setState(() {
        _isUploadingImage = false;
        _pickedImage = null;
      });
      Get.snackbar(
        'Upload Failed',
        'An unexpected error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _handleNext() {
    if (_formKey.currentState!.validate()) {
      if (_pickedImage == null || _imageUrl == null) {
        Get.snackbar(
          'Image Required',
          'Please upload a dish photo to proceed.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      if (_selectedCategoryName == null) {
        Get.snackbar(
          'Category Required',
          'Please select a category.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // Gather all data, aligning with the new Recipe model structure
      final recipeData = {
        'name': _recipeNameController.text,
        'description': _descriptionController.text,
        'cookingTime': '${_cookingTimeController.text} min',
        'servingSize': '${_servingSizeController.text} servings',
        'category': _selectedCategoryName, // This is categoryName
        'categoryId': _getCategoryIdFromName(_selectedCategoryName), // New categoryId
        'imageUrl': _imageUrl,
        'authorName': 'Current User', // TODO: Get actual user name from Supabase auth
        'authorAvatarUrl': null, // TODO: Get actual user avatar URL if available
        // 'createdAt' will be set by Supabase database default value (now())
        'shortDescription': _descriptionController.text.length > 100
            ? _descriptionController.text.substring(0, 100) + '...'
            : _descriptionController.text, // Simple short description
      };

      JumpAction.toAddIngredientsSteps(recipeData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'New Recipe',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFormLabel('Recipe Name'),
              _buildTextField(
                controller: _recipeNameController,
                hintText: 'Enter recipe name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a recipe name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              _buildFormLabel('Description'),
              _buildTextField(
                controller: _descriptionController,
                hintText: 'Describe your recipe',
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please describe your recipe';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              _buildFormLabel('Cooking Time (minutes)'),
              _buildTextField(
                controller: _cookingTimeController,
                hintText: 'Enter cooking time',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter cooking time';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              _buildFormLabel('Serving Size'),
              _buildTextField(
                controller: _servingSizeController,
                hintText: 'Enter serving size',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter serving size';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              _buildFormLabel('Category'),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedCategoryName,
                    hint: const Text('Select category'),
                    icon: const Icon(Icons.unfold_more, color: Colors.grey),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategoryName = newValue;
                      });
                    },
                    items: _recipeCategories.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Upload Dish Photo section
              GestureDetector(
                onTap: _isUploadingImage ? null : _pickImage,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      _isUploadingImage
                          ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(strokeWidth: 2))
                          : Icon(_pickedImage != null ? Icons.check_circle : Icons.photo_library_outlined,
                          color: _pickedImage != null ? Colors.green : Colors.grey),
                      const SizedBox(width: 10),
                      Text(
                        _pickedImage != null
                            ? 'Image Selected'
                            : (_isUploadingImage ? 'Uploading...' : 'Upload Dish Photo'),
                        style: TextStyle(
                          color: _pickedImage != null ? Colors.green : Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      if (_pickedImage != null && !_isUploadingImage)
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.file(
                                _pickedImage!,
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Next Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isUploadingImage ? null : _handleNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B4EEF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isUploadingImage
                      ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Text('Next', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      validator: validator,
    );
  }
}