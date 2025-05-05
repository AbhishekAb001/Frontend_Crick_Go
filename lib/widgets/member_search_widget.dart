import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class MemberSearchWidget extends StatefulWidget {
  final List<Map<String, dynamic>> members;
  final List<Map<String, dynamic>> initialSelectedMembers;
  final String hintText;
  final Function(List<Map<String, dynamic>>) onSelectedMembersChanged;

  const MemberSearchWidget({
    super.key,
    required this.members,
    this.initialSelectedMembers = const [],
    this.hintText = 'Search members...',
    required this.onSelectedMembersChanged,
  });

  @override
  State<MemberSearchWidget> createState() => _MemberSearchWidgetState();
}

class _MemberSearchWidgetState extends State<MemberSearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredMembers = [];
  late List<Map<String, dynamic>> selectedMembers;

  @override
  void initState() {
    super.initState();
    selectedMembers = List.from(widget.initialSelectedMembers);
  }

  void _filterMembers(String query) {
    setState(() {
      filteredMembers = widget.members.where((member) {
        final name = member['name'].toString().toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList();
    });
  }

  void _handleMemberSelection(Map<String, dynamic> member) {
    setState(() {
      if (!selectedMembers.contains(member)) {
        selectedMembers.add(member);
        widget.onSelectedMembersChanged(selectedMembers);
      }
      _searchController.clear();
      filteredMembers = [];
    });
  }

  void _handleMemberRemoval(int index) {
    setState(() {
      selectedMembers.removeAt(index);
      widget.onSelectedMembersChanged(selectedMembers);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (selectedMembers.isNotEmpty)
          Container(
            height: height * 0.08,
            margin: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: selectedMembers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.004,
                      vertical: height * 0.0005,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.white.withOpacity(0.15)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '@${selectedMembers[index]["username"]}',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: width * 0.01,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: width * 0.001),
                        InkWell(
                          onTap: () => _handleMemberRemoval(index),
                          child: Icon(
                            Icons.close,
                            color: Colors.white.withOpacity(0.8),
                            size: width * 0.01,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: width * 0.02),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: _filterMembers,
            style: GoogleFonts.poppins(color: Colors.white),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: GoogleFonts.poppins(color: Colors.white70),
              prefixIcon: Icon(Icons.search, color: Colors.blue),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.015,
              ),
            ),
          ),
        ),
        if (filteredMembers.isNotEmpty && _searchController.text.isNotEmpty)
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: height * 0.01),
                itemCount: filteredMembers.length,
                itemBuilder: (context, index) {
                  return FadeInUp(
                    duration: Duration(milliseconds: 100 * (index + 1)),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () =>
                            _handleMemberSelection(filteredMembers[index]),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.05,
                              vertical: height * 0.015),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '@${filteredMembers[index]["username"]}',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: width * 0.01,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
