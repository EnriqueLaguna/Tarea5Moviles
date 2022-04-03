import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foto_share/content/mis_fotos/bloc/misfotos_bloc.dart';
import 'package:foto_share/content/mis_fotos/mis_fotos_edit.dart';

class ItemMisFotos extends StatefulWidget {
  final Map<String, dynamic> allMyData;
  ItemMisFotos({Key? key, required this.allMyData}) : super(key: key);

  @override
  State<ItemMisFotos> createState() => _ItemMisFotosState();
}

class _ItemMisFotosState extends State<ItemMisFotos> {

  bool _switchValue = false;

  @override
  void initState() {
    
    _switchValue = widget.allMyData["public"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 16/9,
              child: Image.network("${widget.allMyData["picture"]}",
              fit: BoxFit.cover,),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Text("${widget.allMyData["username"].toString()[0]}"),
              ),
              title: Text("${widget.allMyData["title"]}",overflow: TextOverflow.ellipsis,),
              subtitle: Text("${widget.allMyData["publishedAt"].toDate()}", overflow: TextOverflow.ellipsis),
            ),
            Wrap(
              spacing: 10.0,
              children: [
                MaterialButton(
                  color: Colors.grey,
                  child: Text("Editar"),
                  onPressed: (){
                    //Obtener la infomacion de la imagen que editare. Necesito el Doc
                    String dataToEdit = widget.allMyData["docId"];
                    bool switchValue = widget.allMyData["public"];
                    print(dataToEdit);
                    //BlocProvider.of<MisfotosBloc>(context).add(OnClickEditarButtonEvent(dataToEdit: dataToEdit));
                    //Usar Navigation.push
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => MisFotosEdit(
                        docIdString: dataToEdit, 
                        switchCurrentValue:switchValue,
                        currentImage: widget.allMyData["picture"],
                        currentName: widget.allMyData["title"],
                      ))
                    );

                  }),
                Switch(value: _switchValue, onChanged: (newVal){
                  setState(() {
                    _switchValue = newVal;
                  });
                }),
                IconButton(
                  icon: Icon(Icons.star_outlined, color: Colors.green),
                  tooltip: "Likes: ${widget.allMyData["stars"]}",
                  onPressed: () {},
                ),
              ],
            ),
            
          ],
        )
      ),
    );
  }
}