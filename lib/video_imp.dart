 import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
int _currentIndex = 0;
VideoPlayerController _controller ;

String _videoDuration(Duration duration){
  String twoDigits(int n) => n.toString().padLeft(2,'0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));

  return [
    if(duration.inHours > 0)hours ,minutes, seconds,
  ].join(':');
}

class Video{
  final String name ; 
  final String url ; 
  final String thumbnail ; 

  const Video({
    required this.name,
    required this.url,
    required this.thumbnail,
  });
 }

 const Videos = [
  Video(
    name:'Income and Expense Managment ',
    url:'https://adventr.io/published/income-and-expense-management-87930050?crc=2',
    thumbnail:'https://uploads-ssl.webflow.com/5f841209f4e71b2d70034471/6078b650748b8558d46ffb7f_Flutter%20app%20development.png'
  ),
   Video(
    name:'Learn FLutter 1',
    url:'https://youtu.be/j-LOab_PzzU',
    thumbnail:'https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg'
  ),
   Video(
    name:'Learn Flutter 2',
    url:'https://youtu.be/x0uinJvhNxI',
    thumbnail:'https://149695847.v2.pressablecdn.com/wp-content/uploads/2019/11/1_73IgUxPfyXUKZAaIXgutrw.png'
  ),
  
 ]

class VideoPlayerPage extends StatefulWidget{
  const VideoPlayerPage({Key? key}) : super(key: key);

  @override
  State<VideoPlayerPage> createState()=> _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage>{
  
void _playVideo({int index = 0 , bool init = false}){
  if(index < 0 || index >= videos.length)return;

  _controller = VideoPlayerController.network(
    videos[_currentIndex].url
  );
  ..addListener(()=>setState(( ) { }))
  ..setLooping(true)
  ..initialize().then((value) => _controller.play())
}

  @override
  void initState(){
    super.initState();
    _playVideo(init: true);
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)=> Scaffold(
    appBar:Appbar(
      title:const Text('Video Player'),
      centerTitle : true,
    ),
    body:Column(
      children:[
        Container(
                    color: Colors.deepPurpleAccent,
                    height:300,
                    child:_controller.value.isInitialized
                    ?Column(
                      children:<Widget>[
                        SizedBox(
                          height:200,
                          child:VideoPlayer(_controller),
                        ),
                        const SizedBox(height : 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ValueListenableBuilder(
                              valueListenable: _controller,
                              builder:(context,VideoPlayerValue value , child){
                                return Text(
                                  _videoDuration(value.position),
                                  style:const TextStyle(
                                    color:Colors.white,
                                    fontSize: 20,
                                  ),
                                );
                              },
                              ),
                            Expanded(
                              child: SizedBox(
                                child: VideoProgressIndicator(
                                  _controller ,
                                  allowScrubbing : true ,
                              padding : const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 0,
                                )
                            ),),),
                          ],)
                      ],
                    )
                    : const Center(
                      child:CircularProgressIndicator(color: Colors.white,) ,
                      ),
                  ),
        Expanded
        (
        child:ListView.builder(
          itemCount: videos.length,
          itemBuilder: (context,index){
            return Padding(
              padding:const EdgeInsets.symmetric(horizontal:12),
              child:Row(
                
                children: [
                  
                  SizedBox(
                    height:100,
                    width:100,
                    child:Image.network(
                      videos[index].thumbnail,
                      fit:BoxFit.contain,
                    ),
                    ),
                  )
                ],)
            )
          },
        ),
        ),
      ],
    ),
  );