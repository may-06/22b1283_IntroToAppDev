import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Home(),
  routes:{
    "/home":(context)=>Home(),
    "/page2":(context)=>SecondPage(),
},
));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          "Budget Tracker",
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
        centerTitle: true,
        actions:[
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,40,0),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context,'/page2');

              },
                icon:Icon(Icons.arrow_forward)    ,
            ),
          ),
        ],
        backgroundColor: Colors.grey[850],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 50.0, 30, 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10.0),
              Icon(
                Icons.account_circle,
                color: Colors.grey,
                size: 80.0,
              ),
              SizedBox(height: 30.0),
              Text(
                "Welcome back!",
                style: TextStyle(
                  color: Colors.amber[200],
                  fontSize: 30.0,
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }


}





class SecondPage extends StatefulWidget {
  const SecondPage({super.key});
  State<SecondPage> createState() => _SecondPageState();
}
class CatExp{
  String Cat="";
  double Exp=0;
  CatExp({required this.Cat, required this.Exp});
}
class _SecondPageState extends State<SecondPage> with AutomaticKeepAliveClientMixin<SecondPage>{
  bool get wantKeepAlive => true;
  List<CatExp> catexp=[];
  double exp=0;
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          "Budget Tracker",
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 50.0, 30, 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10.0),
              Icon(
                Icons.account_circle,
                color: Colors.grey,
                size: 80.0,
              ),
              SizedBox(height: 30.0),



                 Container(
                     padding:EdgeInsets.symmetric(horizontal:10.0,vertical:8.0),
                        child : Text(
                    "Total : $exp",
                     style:TextStyle(
                       fontSize:20.0,
                     )
                ),
                color: Colors.white,
              ),

               SizedBox(height:10.0),





              Expanded(
              child:ListView.builder(
                  itemCount: catexp.length,
                  itemBuilder:(context,index){
                    return Card(
                      child: ListTile(
                        title:Text(catexp[index].Cat),
                        subtitle:Text("${catexp[index].Exp}"),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // When delete icon is clicked, remove the category entry and update the total expense.
                            setState(() {
                              exp -= catexp[index].Exp;
                              catexp.removeAt(index);
                            });
                          },
                        ),
                      ),
                    );

               }
                   ),
               ),
          ],
          ),
        ),
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDialog();
        },
        child: Icon(Icons.add),
        backgroundColor:Colors.grey[850],
      ),
    );

  }

  Future openDialog() async {
    String Val1="";
    String Val2="";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title:Text("New Entry"),
          content: Column(
              children:[
                TextField(
                    onChanged:(value){
                      Val1=value;
                    },
                    decoration:InputDecoration(
                      hintText: 'Category name',
                    )
                ),
                TextField(
                    onChanged:(value){
                      Val2=value;
                    },
                    decoration:InputDecoration(
                      hintText: 'Amount',
                    )
                )

              ]
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Do something with the 'category' and 'amount' values here
                // Create a new CategoryExpense instance and add it to the list
                setState(() {
                  catexp.add(CatExp(Cat:Val1,Exp:double.parse(Val2)));
                  exp+=double.parse(Val2);
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Ok'),
            ),
            TextButton(
              onPressed:(){
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ]
      ),
    );
  }
}
