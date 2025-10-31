import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(LuqmanApp());
}

class LuqmanApp extends StatefulWidget {
  @override
  State<LuqmanApp> createState() => _LuqmanAppState();
}

class _LuqmanAppState extends State<LuqmanApp> with TickerProviderStateMixin {
  int _themeIndex = 0;
  double _fontSize = 18;
  int _alignMode = 0;
  
  late AnimationController _animController;
  double _animValue = 0;
  
  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30), // Slow smooth animation
    )..repeat();
    
    _animController.addListener(() {
      setState(() {
        _animValue = _animController.value;
      });
    });
  }
  
  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> _themes = [
    {
      "name": "Sunset",
      "icon": Icons.wb_sunny,
      "gradient": LinearGradient(
        colors: [Color(0xFFFF6B35), Color(0xFFF7931E), Color(0xFFFDC830)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    },
    {
      "name": "Night Sky",
      "icon": Icons.nightlight_round,
      "gradient": LinearGradient(
        colors: [Color(0xFF000428), Color(0xFF004e92)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    },
    {
      "name": "Forest",
      "icon": Icons.terrain,
      "gradient": LinearGradient(
        colors: [Color(0xFF134E5E), Color(0xFF71B280)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    },
    {
      "name": "Ocean",
      "icon": Icons.water,
      "gradient": LinearGradient(
        colors: [Color(0xFF2E3192), Color(0xFF1BFFFF)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    },
  ];

  void _nextTheme() {
    setState(() {
      _themeIndex = (_themeIndex + 1) % _themes.length;
    });
  }

  void _toggleAlign() {
    setState(() {
      _alignMode = (_alignMode + 1) % 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = _themes[_themeIndex];

    Alignment blockAlign;
    TextAlign textAlign;
    double maxWidth;

    if (_alignMode == 0) {
      blockAlign = Alignment.centerLeft;
      textAlign = TextAlign.left;
      maxWidth = 500;
    } else if (_alignMode == 1) {
      blockAlign = Alignment.topCenter;
      textAlign = TextAlign.center;
      maxWidth = 500;
    } else {
      blockAlign = Alignment.centerRight;
      textAlign = TextAlign.right;
      maxWidth = 500;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Tears in Heaven - Lyric App",
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 70,
          title: Row(
            children: [
              Icon(theme["icon"], color: Colors.white70),
              SizedBox(width: 10),
              Text(
                "Tears in Heaven",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.landscape, color: Colors.white),
                tooltip: "Ganti suasana (${theme["name"]})",
                onPressed: _nextTheme,
              )
            ],
          ),
        ),
        body: Stack(
          children: [
            // Background gradient
            Container(
              decoration: BoxDecoration(gradient: theme["gradient"]),
            ),
            
            // Animasi custom untuk setiap tema
            _buildThemeAnimation(),
            
            SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        Text("Tears in Heaven",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                    color: Colors.black54,
                                    blurRadius: 6,
                                    offset: Offset(2, 2))
                              ],
                            )),
                        SizedBox(height: 6),
                        Text("Eric Clapton",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                              fontStyle: FontStyle.italic,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Align(
                        alignment: blockAlign,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: maxWidth),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _lyricCard("Verse 1", """Would you know my name
If I saw you in heaven
Will it be the same
If I saw you in heaven
I must be strong, and carry on
Cause I know I don't belong
Here in heaven""", textAlign),

                              _lyricCard("Verse 2", """Would you hold my hand
If I saw you in heaven
Would you help me stand
If I saw you in heaven
I'll find my way, through night and day
Cause I know I just can't stay
Here in heaven""", textAlign),

                              _lyricCard("Bridge", """Time can bring you down
Time can bend your knee
Time can break your heart
Have you begged it please
Begged it please""", textAlign, icon: Icons.access_time),

                              Center(
                                child: Text("(instrumental)",
                                    style: TextStyle(
                                        fontSize: _fontSize - 2,
                                        color: Colors.white70,
                                        fontStyle: FontStyle.italic)),
                              ),
                              SizedBox(height: 12),

                              _lyricCard("Verse 3", """Beyond the door
There's peace I'm sure.
And I know there'll be no more...
Tears in heaven""", textAlign),

                              _lyricCard("Reprise", """Would you know my name
If I saw you in heaven
Will it be the same
If I saw you in heaven
I must be strong, and carry on
Cause I know I don't belong
Here in heaven""", textAlign),

                              SizedBox(height: 8),
                              Align(
                                alignment: blockAlign,
                                child: Text(
                                  "Cause I know I don't belong\nHere in heaven",
                                  textAlign: textAlign,
                                  style: TextStyle(
                                    fontSize: _fontSize,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black38,
                                          blurRadius: 4,
                                          offset: Offset(2, 2))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    heroTag: "btn1",
                    mini: true,
                    backgroundColor: Colors.blueAccent,
                    onPressed: () {
                      setState(() {
                        _fontSize = (_fontSize < 28) ? _fontSize + 2 : _fontSize;
                      });
                    },
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  FloatingActionButton(
                    heroTag: "btn2",
                    mini: true,
                    backgroundColor: Colors.blueAccent,
                    onPressed: () {
                      setState(() {
                        _fontSize = (_fontSize > 14) ? _fontSize - 2 : _fontSize;
                      });
                    },
                    child: Icon(Icons.remove, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  FloatingActionButton(
                    heroTag: "btn3",
                    mini: true,
                    backgroundColor: Colors.deepPurple,
                    onPressed: _toggleAlign,
                    child: Icon(Icons.format_align_center, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeAnimation() {
    if (_themeIndex == 0) {
      // SUNSET: Cahaya matahari bergerak dengan rays
      return Stack(
        children: [
          // Sun rays rotating
          ...List.generate(12, (index) {
            double angle = (index * 30.0 + _animValue * 360) * math.pi / 180;
            return Positioned(
              left: 200 + math.cos(angle) * 150,
              top: -50 + math.sin(angle) * 150,
              child: Transform.rotate(
                angle: angle,
                child: Container(
                  width: 200,
                  height: 3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.yellow.withOpacity(0.8),
                        Colors.orange.withOpacity(0.4),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          // Light particles floating
          ...List.generate(40, (index) {
            double offset = (_animValue + index * 0.025) % 1.0;
            double x = 50 + (index * 15) % 350;
            double y = 100 + offset * 700;
            return Positioned(
              left: x + math.sin(offset * math.pi * 4) * 30,
              top: y,
              child: Container(
                width: 4 + (index % 3) * 2,
                height: 4 + (index % 3) * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.yellow.withOpacity(0.8),
                      Colors.orange.withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      );
    } else if (_themeIndex == 1) {
      // NIGHT SKY: Aurora borealis full screen bergerak
      return Stack(
        children: [
          // Aurora waves - multiple layers
          ...List.generate(5, (layer) {
            return Positioned(
              left: -200 + (_animValue * 400 * (layer + 1)) % 800,
              top: 100 + layer * 120,
              child: Transform.rotate(
                angle: math.sin(_animValue * math.pi * 2) * 0.2,
                child: Container(
                  width: 800,
                  height: 150,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        (layer % 3 == 0 ? Colors.green : layer % 3 == 1 ? Colors.blue : Colors.purple)
                            .withOpacity(0.3 - layer * 0.04),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          // Stars twinkling
          ...List.generate(60, (index) {
            double twinkle = (math.sin((_animValue * 6 + index) * math.pi) + 1) / 2;
            return Positioned(
              left: (index * 37) % 400,
              top: (index * 53) % 800,
              child: Container(
                width: 2 + (index % 3),
                height: 2 + (index % 3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.3 + twinkle * 0.6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.4 * twinkle),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      );
    } else if (_themeIndex == 2) {
      // FOREST: Daun jatuh + siluet pohon
      return Stack(
        children: [
          // Tree silhouettes
          Positioned(
            bottom: 0,
            left: 50,
            child: CustomPaint(
              size: Size(80, 200),
              painter: TreePainter(),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 70,
            child: CustomPaint(
              size: Size(100, 250),
              painter: TreePainter(),
            ),
          ),
          // Falling leaves
          ...List.generate(30, (index) {
            double offset = (_animValue + index * 0.033) % 1.0;
            double x = (index * 25) % 400;
            double y = -50 + offset * 900;
            double swing = math.sin(offset * math.pi * 6) * 40;
            double rotation = offset * math.pi * 4;
            return Positioned(
              left: x + swing,
              top: y,
              child: Transform.rotate(
                angle: rotation,
                child: Container(
                  width: 12,
                  height: 15,
                  decoration: BoxDecoration(
                    color: (index % 3 == 0 ? Colors.green : index % 3 == 1 ? Colors.lightGreen : Colors.yellow)
                        .withOpacity(0.7),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      );
    } else {
      // OCEAN: Ombak bergerak
      return Stack(
        children: [
          // Multiple wave layers
          ...List.generate(6, (layer) {
            double waveOffset = (_animValue * (1 + layer * 0.2)) % 2.0;
            return Positioned(
              bottom: 50 + layer * 80,
              left: -200,
              child: CustomPaint(
                size: Size(800, 100),
                painter: WavePainter(
                  waveOffset: waveOffset,
                  color: Colors.white.withOpacity(0.15 - layer * 0.02),
                  amplitude: 20 + layer * 5,
                ),
              ),
            );
          }),
          // Bubbles rising
          ...List.generate(25, (index) {
            double offset = (_animValue + index * 0.04) % 1.0;
            double x = (index * 30) % 400;
            double y = 800 - offset * 900;
            return Positioned(
              left: x + math.sin(offset * math.pi * 3) * 20,
              top: y,
              child: Container(
                width: 8 + (index % 5) * 2,
                height: 8 + (index % 5) * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.4), width: 2),
                  gradient: RadialGradient(
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.cyan.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      );
    }
  }

  Widget _lyricCard(String title, String content, TextAlign textAlign, {IconData? icon}) {
    CrossAxisAlignment cardCrossAlign;
    MainAxisAlignment rowMainAlign;
    
    if (textAlign == TextAlign.right) {
      cardCrossAlign = CrossAxisAlignment.end;
      rowMainAlign = MainAxisAlignment.end;
    } else if (textAlign == TextAlign.center) {
      cardCrossAlign = CrossAxisAlignment.center;
      rowMainAlign = MainAxisAlignment.center;
    } else {
      cardCrossAlign = CrossAxisAlignment.start;
      rowMainAlign = MainAxisAlignment.start;
    }
    
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white.withOpacity(0.15),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: Column(
        crossAxisAlignment: cardCrossAlign,
        children: [
          Row(
            mainAxisAlignment: rowMainAlign,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon ?? Icons.music_note, size: 18, color: Colors.white70),
              SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            content,
            textAlign: textAlign,
            style: TextStyle(
              fontSize: _fontSize,
              fontStyle: FontStyle.italic,
              height: 1.5,
              color: Colors.white,
              shadows: [
                Shadow(color: Colors.black54, blurRadius: 4, offset: Offset(1, 1))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter untuk pohon
class TreePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..style = PaintingStyle.fill;
    
    // Batang pohon
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.4, size.height * 0.6, size.width * 0.2, size.height * 0.4),
      paint,
    );
    
    // Daun pohon (3 circles)
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.3), size.width * 0.3, paint);
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.45), size.width * 0.25, paint);
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.45), size.width * 0.25, paint);
  }
  
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Custom painter untuk ombak
class WavePainter extends CustomPainter {
  final double waveOffset;
  final Color color;
  final double amplitude;
  
  WavePainter({required this.waveOffset, required this.color, required this.amplitude});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    final path = Path();
    path.moveTo(0, size.height);
    
    for (double x = 0; x <= size.width; x += 5) {
      double y = size.height / 2 + math.sin((x / 50 + waveOffset * math.pi)) * amplitude;
      path.lineTo(x, y);
    }
    
    path.lineTo(size.width, size.height);
    path.close();
    
    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(WavePainter oldDelegate) => 
    oldDelegate.waveOffset != waveOffset;
}