import 'package:flutter/material.dart';
import 'package:music_playlist/core.dart';
import 'package:music_playlist/domain/database.dart';
import 'package:music_playlist/domain/library_model.dart';

class ScreenMusicLibrary extends StatefulWidget {
  const ScreenMusicLibrary({super.key});

  @override
  State<ScreenMusicLibrary> createState() => _ScreenMusicLibraryState();
}

class _ScreenMusicLibraryState extends State<ScreenMusicLibrary> {
  final musicNameController = TextEditingController();
  final artistNameController = TextEditingController();

  List<MusicModel> musicModelList = [
    // MusicModel(musicId: '1', musicName: 'Dilsere', musicArtist: 'A.R. Rahman'),
    // MusicModel(
    //     musicId: '2',
    //     musicName: 'Taal Se Taal Mila',
    //     musicArtist: 'Sukhwinder Sing'),
    // MusicModel(
    //     musicId: '3',
    //     musicName: 'Yun Hi Chala Chal',
    //     musicArtist: 'Javeed Akthar'),
  ];

  int id = 0;
  @override
  Widget build(BuildContext context) {
    loadUserName();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Music Playlist App',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: musicNameController,
                            decoration: const InputDecoration(
                                hintText: 'Track Name',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)))),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              id++;
                              MusicModel m = MusicModel(
                                  musicId: id.toString(),
                                  musicName: musicNameController.text,
                                  musicArtist: artistNameController.text);
                              addMusic(m);
                              loadUserName();
                            },
                            child: const Text('Add'))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: artistNameController,
                            decoration: const InputDecoration(
                                hintText: 'Artist Name',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)))),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .19,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * .8,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                        onTap: () {
                          //Write code to change status
                        },
                        leading: Text((index + 1).toString()),
                        title: Text(
                          musicModelList[index].musicName,
                          style: const TextStyle(
                              fontSize: 23, color: Colors.purple),
                        ),
                        subtitle: Row(
                          children: [
                            Text(musicModelList[index].musicArtist,
                                style: const TextStyle(
                                    fontSize: 19, color: Colors.pink)),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  deleteMusic("Illuminati ");
                                  //print(musicModelList[index].musicId);
                                  loadUserName();
                                },
                                icon: const Icon(Icons.delete))
                          ],
                        ));
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: musicModelList.length,
                ))
          ],
        ),
      ),
    );
  }

  Future<void> loadUserName() async {
    globalusername = await getUserName(globalUserId);
    await loadDatabase();
    setState(() {
      musicModelList = GlobalMusicList;
      id = int.parse(gid);
    });
  }
}
