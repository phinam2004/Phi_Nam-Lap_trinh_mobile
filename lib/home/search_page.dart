import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _results = [];

  void _onSearch(String query) {
    setState(() {
      // Demo: Tìm kiếm giả lập
      _results = query.isEmpty
          ? []
          : List.generate(5, (i) => 'Kết quả cho "$query" #${i + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Tìm kiếm'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearch,
                decoration: InputDecoration(
                  hintText: 'Nhập từ khóa tìm kiếm...',
                  prefixIcon: Icon(Icons.search, color: Colors.blue),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: _results.isEmpty
                  ? Center(
                      child: Text(
                        'Không có kết quả nào.',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    )
                  : ListView.separated(
                      itemCount: _results.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Icon(Icons.search, color: Colors.white),
                            ),
                            title: Text(_results[index]),
                            subtitle: Text('Thông tin chi tiết...'),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.blue,
                            ),
                            onTap: () {},
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
