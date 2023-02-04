import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../icon_content.dart';
import '../constants.dart';
import 'package:bmi_calculator/reusable_card.dart';
import '../bottom_button.dart';
import '../round_icon.dart';
import 'package:bmi_calculator/screens/ResultsPage.dart';
import 'package:bmi_calculator/calculator_brain.dart';


enum Gender {
  Male,Female
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender? selectedGender;
  int height=180;
  int weight=70;
  int age=20;
  // Color maleCardColor = inActiveCardColor;
  // Color femaleCardColor = inActiveCardColor;

  // void updateColor( Gender selectedGender){
  //   selectedGender == Gender.Male ? maleCardColor = activeCardColor:  maleCardColor = inActiveCardColor;
  //   selectedGender == Gender.Female?femaleCardColor = activeCardColor:femaleCardColor = inActiveCardColor;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:<Widget> [
          Expanded(
            child: Row(
            children: [
              Expanded(child: ReusableCard(
                onPress: (){
                  setState(() {
                    selectedGender=Gender.Male;
                  });
                },
                colour: selectedGender==Gender.Male? kActiveCardColor:kInActiveCardColor,
                cardChild: IconContent(icon:FontAwesomeIcons.mars, label:'MALE'),
              ),
              ),
              Expanded(child: ReusableCard(
                  onPress: (){
                    setState(() {
                      selectedGender=Gender.Female;
                    });
                  },
                  colour: selectedGender == Gender.Female ? kActiveCardColor:kInActiveCardColor,
              cardChild: IconContent(icon:FontAwesomeIcons.venus, label:'FEMALE')
              ),),
            ],
          ),),
          Expanded(child: ReusableCard(
            colour: kActiveCardColor,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('HEIGHT',
                style: kLabelTextStyle,
                ),Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children:<Widget> [
                    Text(height.toString(),
                    style: kNumberTextStyle,
                    ),
                    Text('cm' , style: kLabelTextStyle,)
                  ],
                ),
                SliderTheme(
                  data:SliderTheme.of(context).copyWith(
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0)
                  ),
                  child: Slider(value: height.toDouble(),
                      min:120.0,
                      max:220.0,
                      activeColor: Color(0xFFEB1555),
                      inactiveColor: Color(0xFF8D8E98),
                      onChanged: (double newValue){
                        setState(() {
                          height = newValue.round();
                        });
                      },
                  ),
                )

              ],
            ),

          ),
          ),
          Expanded(
            child: Row(
            children: [
              Expanded(
                child: ReusableCard(
                colour: kActiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('WEIGHT',
                    style: kLabelTextStyle,
                    ),
                    Text(
                      weight.toString(),
                      style: kNumberTextStyle,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundIconButton(icon: FontAwesomeIcons.plus,
                          onPress: (){
                            setState(() {
                              weight++;
                            });
                          },
                        ),
                        SizedBox(width: 10,),
                        RoundIconButton(icon: FontAwesomeIcons.minus,
                          onPress: (){
                            setState(() {
                              if(weight>1){
                                weight--;
                              }

                            });
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
              ),
              Expanded(child:ReusableCard(
                colour: kActiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('AGE',
                    style: kLabelTextStyle,
                    ),
                  Text(age.toString(), style: kNumberTextStyle,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                      RoundIconButton(icon: FontAwesomeIcons.plus,
                      onPress: (){
                        setState(() {
                          age++;

                        });
                      },


                      ),
                        SizedBox(width: 10,),
                        RoundIconButton(icon: FontAwesomeIcons.minus,
                          onPress: (){
                            setState(() {
                              if(age>1){
                                age--;
                              }

                            });
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
              ),
            ],
          ),
          ),
          BottomButton(
            buttonTitle: 'CALCULATE',
            onTap: (){
              CalculatorBrain calc = CalculatorBrain(height: height, weight: weight);
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ResultsPage(
                  bmiResult: calc.calculateBMI(),
                  resultText:calc.getResults() ,
                  interpretation: calc.getInterpretation(),
                );
              },),);
            },
          ),
        ],
      ),

    );
  }
}


