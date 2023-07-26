import 'package:fitlife/fancy_loader.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key})
      : super(key: key); // Add 'Key?' to fix the constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitLife',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const WelcomePage(title: 'FitLife',),
    );
  }
}


class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Create the fade-in animation for the "Welcome to FitLife!" text
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Create the button scale animation for the "Get Started" button
    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated "Welcome to FitLife!" text with gradient effect
              FadeTransition(
                opacity: _fadeInAnimation,
                child: ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      colors: [Colors.orange, Colors.green],
                      stops: [0.0, 1.0],
                    ).createShader(bounds);
                  },
                  child: const Text(
                    'Welcome to FitLife!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),

              const SizedBox(
                width: 100,
                height: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FancyLoader(
                      animationType: AnimationType.gradient,
                      size: 50.0,
                      duration: Duration(milliseconds: 1000),
                      startColor: Colors.blue,
                      endColor: Colors.green,
                    ),
                    SizedBox(height: 20),
                    FancyLoader(
                      animationType: AnimationType.pulsing,
                      size: 50.0,
                      duration: Duration(milliseconds: 800),
                      startColor: Colors.blue,
                      endColor: Colors.green,
                    ),
                    SizedBox(height: 20),
                    FancyLoader(
                      animationType: AnimationType.rotating,
                      size: 50.0,
                      duration: Duration(milliseconds: 1200),
                      startColor: Colors.blue,
                      endColor: Colors.green,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              ScaleTransition(
                scale: _buttonScaleAnimation,
                child: Material(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.red,
                  child: InkWell(
                    onTap: () => _goToGetStarted(context),
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: 150,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text(
                        'Get Started',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to navigate to the GetStarted page
  void _goToGetStarted(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GetStarted(title: widget.title),
      ),
    );
  }
}

        



class GetStarted extends StatelessWidget {
  const GetStarted({Key? key, required String title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.green,
        hintColor: Colors.orange,
        textTheme: const TextTheme(
          headline6: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(fontSize: 20),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("BMI Calculator"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   'assets/bmi.jpg',
              //   height: 450,
              //   width: 350,
              // ),
              const SizedBox(height: 24),
              Material(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.green, // Replace with your desired button color
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const HomePage(title: 'BMI CALCULATOR'),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(50.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 15.0,
                    ),
                    child: const Text(
                      "GET STARTED",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required String title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String _result = '';
  late AnimationController _animationController;
  late Animation<double> _buttonAnimation;
  late Animation<double> _containerAnimation;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _buttonAnimation = Tween<double>(begin: 1, end: 0.95).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _containerAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _textAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _calculateBMI() {
    final height = double.tryParse(_heightController.text);
    final weight = double.tryParse(_weightController.text);

    if (height == null || weight == null || height <= 0 || weight <= 0) {
      setState(() {
        _result = 'Please enter valid values.';
      });
      return;
    }

    final bmi = weight / (height * height);
    final status = bmi < 18.5
        ? 'Underweight'
        : bmi < 25
            ? 'Normal'
            : bmi < 30
                ? 'Overweight'
                : 'Obese';

    setState(() {
      _result = 'BMI: ${bmi.toStringAsFixed(2)}, Status: $status';
    });
  }

  void _resetFields() {
    _heightController.text = '';
    _weightController.text = '';
    setState(() {
      _result = '';
    });
    _animationController.reverse(); // Add this line to reverse the animation
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        hintColor: Colors
            .green, // Set the accent color to green for the ElevatedButton
        textTheme: const TextTheme(
          headline6: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(fontSize: 20),
        ),
      ),
      home: Scaffold(
        backgroundColor:  Colors.white,
        appBar: AppBar(
          title: const Text('BMI Calculator'),
          centerTitle: true,
          backgroundColor: Colors.amberAccent,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ScaleTransition(
                    scale: _textAnimation,
                    // child: const Text(
                    //   'BMI Calculator',
                    //   style: TextStyle(
                    //       fontSize: 28,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.amber),
                    //   textAlign: TextAlign.center,
                    // ),
                  ),
                  const SizedBox(height: 24),
                  FadeTransition(
                    opacity: _containerAnimation,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.lightGreen,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _heightController,
                            decoration: InputDecoration(
                              labelText: 'Height (meters)',
                              prefixIcon: const Icon(Icons.height),
                              border: OutlineInputBorder(
                                // Add Material Design border
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              fillColor:  const Color.fromARGB(255, 207, 210, 178),
                              // Set the background color of the field
                              filled:
                                  true, // Set to true to fill the field with the specified color
                            ),
                            keyboardType:
                                const TextInputType.numberWithOptions(decimal: true),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _weightController,
                            decoration: InputDecoration(
                              labelText: 'Weight (kilograms)',
                              prefixIcon: const Icon(Icons.line_weight),
                              border: OutlineInputBorder(
                                // Add Material Design border
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              fillColor: const Color.fromARGB(255, 207, 210, 178), // Set the background color of the field
                              filled:
                                  true, // Set to true to fill the field with the specified color
                            ),
                            keyboardType:
                                const TextInputType.numberWithOptions(decimal: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ScaleTransition(
                    scale: _buttonAnimation,
                    child: ElevatedButton(
                      onPressed: () {
                        _calculateBMI();
                        _animationController.forward();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors
                            .green, // Set the background color of the button
                      ),
                      child: const Text(
                        'Calculate BMI',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FadeTransition(
                    opacity: _textAnimation,
                    child: Text(
                      _result,
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: ScaleTransition(
          scale: _buttonAnimation,
          child: FloatingActionButton(
            onPressed: () {
              _resetFields();
              _animationController.reverse();
            },
            backgroundColor: Colors.red,
            child: const Icon(Icons.refresh),
          ),
        ),
      ),
    );
  }
}
