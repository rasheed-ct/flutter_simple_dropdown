library flutter_simple_dropdown;
import 'package:flutter/material.dart';
class FlutterSimpleDropdown extends StatefulWidget {
  const FlutterSimpleDropdown({Key? key}) : super(key: key);

  @override
  State<FlutterSimpleDropdown> createState() => _FlutterSimpleDropdownState();
}

class _FlutterSimpleDropdownState extends State<FlutterSimpleDropdown> with TickerProviderStateMixin {

  late AnimationController animationController;
  late AnimationController iconController;
  late Animation<double>  animation;
  late Animation<double>  iconAnimation;
  late Animation<double>  stableAnim;
  bool isOpen = false;
  @override
  void initState() {
    // TODO: implement onInit
    super.initState();
    iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    ) ;
    iconAnimation = Tween<double>(begin: 0, end: 0.5).animate(iconController);
    if ( isOpen) {
      iconController.value = 0.5;
    }
    stableAnim = Tween<double>(begin: 0, end: 0).animate(iconController);
     
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addListener(() {
       setState(() {
         if (isOpen) {
           iconController.forward();
         } else {

           iconController.reverse();
         }
       });
    });
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }
  @override
  void dispose() {
    // TODO: implement onClose
    super.dispose();
    iconController.dispose();
    animationController.dispose();
  }
  void toggle(int index) {
    // if (animation.status != AnimationStatus.completed && isSelected == index) {
    //   animationController.forward();
    // } else {
    //     animationController.animateBack(0, duration: const Duration(seconds: 1));
    // }
    if(isOpen){
      animationController.forward();
    }else{
      animationController.reverse();
    }
  }

  int isSelected = 0;
  

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  Expanded(
      child: Container(
        height: size.height,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 20,
            itemBuilder: (context , index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {

                      if ( isSelected == index) {
                        isSelected = 0;
                      } else {
                        isSelected = index;
                      }
                      isOpen = !isOpen;
                      toggle(index);
                    });
                  },
                  child: Container(
                    width: size.width,
                    decoration:  BoxDecoration(
                      color: Colors.deepPurple.shade200,
                      borderRadius:

                      isSelected== index &&   isOpen?
                      const BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)
                      )
                          :
                      isSelected== index && animationController.isAnimating?
                      const BorderRadius.only(
                        bottomRight: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        topLeft:   Radius.circular(30),
                        topRight:  Radius.circular(30),
                      )
                          : BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text('Toggle Container' ,  style: Theme.of(context).textTheme.titleSmall,),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RotationTransition(
                            turns: isSelected== index?
                            iconAnimation : CurvedAnimation(parent: stableAnim, curve: Curves.linear),
                            child: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizeTransition(
                  axis: Axis.vertical,
                  // axisAlignment: -1,
                  sizeFactor: isSelected== index?
                  CurvedAnimation(
                      parent:  animationController,
                      curve: Curves.easeInOut
                  ): CurvedAnimation(parent: stableAnim, curve: Curves.linear),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius:isOpen? const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                        )
                            : animationController.isAnimating?
                        const BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        )
                            :
                           BorderRadius.circular(0)
                    ),
                    child: ListView.builder(
                      physics:   const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      shrinkWrap: true,
                      itemBuilder: (context , index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('body' , style: Theme.of(context).textTheme.bodyMedium,),
                        );
                      },
                    ),
                  ),
                ),

              ],
            ),
          );
        }),
      ),
    );
  }
}

