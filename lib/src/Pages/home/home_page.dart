import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/widgets/bezierContainer.dart';

class HomePage extends StatefulWidget {
	static final String routeName = 'home_page';
    HomePage({Key key}) : super(key: key);
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  	@override
  	Widget build(BuildContext context) {
    	final height = MediaQuery.of(context).size.height;
		return Scaffold(
			drawer: Drawer( 
        		child: Container(
        		  	child: ListView(
          				children: <Widget>[
							Container(
								color: Color(0xfff7892b),
								height: 150,
								child: Row(
									children: <Widget>[
										Container(
											padding: EdgeInsets.all(10),
											child: CircleAvatar(maxRadius: 35,),
										),
										Container(
											child: Column(
												mainAxisAlignment: MainAxisAlignment.center,
												crossAxisAlignment: CrossAxisAlignment.start,
												children: <Widget>[
													Text('Administrador'),
													Text('Gallotto, Hugo Andrés'),
												],
											),
										)
									],
								),
							),
							Divider(color: Colors.white,),
            				ListTile(
              					leading: Container(width: 50.0, child: Icon(Icons.account_circle, color: Color(0xfff7892b),)),
              					trailing: Icon(Icons.navigate_next, color: Color(0xfff7892b),),
              					title: Text('Opción 1!'),
              					onTap: (){
									//do something
                					Navigator.pop(context);
              					},
            				),
							Divider(color: Color(0xfff7892b),),
							ListTile(
              					leading: Container(width: 50.0, child: Icon(Icons.add_to_home_screen, color: Color(0xfff7892b),)),
              					trailing: Icon(Icons.navigate_next, color: Color(0xfff7892b),),
              					title: Text('Opción 2!'),
              					onTap: (){
									//do something
                					Navigator.pop(context);
              					},
            				),
							Divider(color: Color(0xfff7892b)),
							ListTile(
              					leading: Container(width: 50.0, child: Icon(Icons.face, color: Color(0xfff7892b),)),
              					trailing: Icon(Icons.navigate_next, color: Color(0xfff7892b),),
              					title: Text('Opción 3!'),
              					onTap: (){
									//do something
                					Navigator.pop(context);
              					},
            				),
							Divider(color: Color(0xfff7892b)),
							ListTile(
              					leading: Container(width: 50.0, child: Icon(Icons.all_inclusive, color: Color(0xfff7892b),)),
              					trailing: Icon(Icons.navigate_next, color: Color(0xfff7892b),),
              					title: Text('Opción 4!'),
              					onTap: (){
									//do something
                					Navigator.pop(context);
              					},
            				),
						]
					),
        		)	
			),
			appBar: AppBar(
				title: Text('Grupo tigre', style: TextStyle(fontSize: 20.0)),
				backgroundColor: Color(0xfff7892b),
				centerTitle: false,
				//leading:  Icon(Icons.menu),
        			
			),
            
        	body: Container(
      			height: height,
      			child: Stack(
        			children: <Widget>[
          				Positioned(
              				top: -height * .15,
              				right: -MediaQuery.of(context).size.width * .4,
              				child: BezierContainer()
						),
					]
				)
			)
		);
  	}
}