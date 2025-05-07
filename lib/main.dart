import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';

// إنشاء كائن AudioPlayer لتشغيل الأصوات
AudioPlayer audioPlayer = AudioPlayer();

void main() {
  // تهيئة AudioPlayer عند بدء التطبيق
  audioPlayer = AudioPlayer();
  runApp(const SustainabilityQuizApp());
}

// تعريف التطبيق الرئيسي
class SustainabilityQuizApp extends StatelessWidget {
  const SustainabilityQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "لعبة الاستدامة",
      theme: ThemeData(primarySwatch: Colors.green), // تعيين اللون الرئيسي
      home: const HomePage(), // تحديد الصفحة الرئيسية
    );
  }
}

// الصفحة الرئيسية للتطبيق
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("لعبة الاستدامة")),
      body: Stack(
        children: [
          // تعيين صورة الخلفية
          Positioned.fill(
            child: Image.asset(
              'assets/image.png',
              fit: BoxFit.cover,
            ),
          ),
          // محتوى الصفحة
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center, // توسيط أفقياً
              children: [
                Container(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.5), // خلفية شفافة للنص
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    'مرحبًا بك في لعبة الاستدامة',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // زر بدء اللعبة
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const QuizPage()),
                    );
                  },
                  child: const Text("ابدأ اللعب"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// صفحة الأسئلة (Quiz)
class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0; // تتبع السؤال الحالي
  int score = 0; // تسجيل النقاط
  int timeLeft = 30; // العداد الزمني لكل سؤال
  Timer? timer; // المؤقت

  // قائمة بالأسئلة والإجابات
  final List<Map<String, dynamic>> questions = [
   {
      'question': 'ما هو الهدف الرئيسي من الاستدامة؟',
      'answers': ['الحفاظ على الموارد', 'زيادة الاستهلاك', 'تلويث البيئة'],
      'correctAnswer': 'الحفاظ على الموارد',
    },
    {
      'question': 'ما هي إحدى طرق تقليل البصمة الكربونية؟',
      'answers': [
        'استخدام السيارات الكهربائية',
        'زيادة استخدام البلاستيك',
        'إزالة الغابات'
      ],
      'correctAnswer': 'استخدام السيارات الكهربائية',
    },
    {
      'question': 'ما هي الطاقة المتجددة؟',
      'answers': [
        'الطاقة التي تأتي من مصادر لا تنضب',
        'الطاقة الناتجة عن الوقود الأحفوري',
        'الطاقة النووية'
      ],
      'correctAnswer': 'الطاقة التي تأتي من مصادر لا تنضب',
    },
    {
      'question': 'ما هي فائدة إعادة التدوير؟',
      'answers': [
        'تقليل كمية النفايات',
        'زيادة التلوث',
        'زيادة استخدام الموارد الطبيعية'
      ],
      'correctAnswer': 'تقليل كمية النفايات',
    },
    {
      'question': 'ما هو تأثير إزالة الغابات على البيئة؟',
      'answers': [
        'زيادة نسبة ثاني أكسيد الكربون',
        'زيادة نسبة الأكسجين',
        'تحسين جودة الهواء'
      ],
      'correctAnswer': 'زيادة نسبة ثاني أكسيد الكربون',
    },
    {
      'question': 'ما هو المصدر الرئيسي للطاقة النظيفة؟',
      'answers': ['الشمس', 'الوقود الأحفوري', 'الخشب'],
      'correctAnswer': 'الشمس',
    },
    {
      'question': 'كيف يمكن تقليل استهلاك المياه في المنزل؟',
      'answers': [
        'إصلاح التسريبات',
        'ترك الصنبور مفتوحًا',
        'استخدام مياه الشرب للري'
      ],
      'correctAnswer': 'إصلاح التسريبات',
    },
    {
      'question': 'ما هي أهمية التشجير في المناطق الحضرية؟',
      'answers': [
        'تحسين جودة الهواء',
        'زيادة نسبة ثاني أكسيد الكربون',
        'زيادة درجة الحرارة'
      ],
      'correctAnswer': 'تحسين جودة الهواء',
    },
    {
      'question': 'أي من التالي يُعتبر من ممارسات الاستدامة؟',
      'answers': [
        'إعادة استخدام المواد',
        'التخلص من النفايات في البحر',
        'حرق النفايات في الهواء الطلق'
      ],
      'correctAnswer': 'إعادة استخدام المواد',
    },
    {
      'question': 'ما هو تأثير ارتفاع مستوى سطح البحر على المجتمعات الساحلية؟',
      'answers': [
        'فقدان الأراضي',
        'زيادة التنوع البيولوجي',
        'تحسن جودة المياه'
      ],
      'correctAnswer': 'فقدان الأراضي',
    },
    
  ];

  @override
  void initState() {
    super.initState();
    startTimer(); // بدء العداد الزمني عند فتح صفحة الأسئلة
  }

  @override
  void dispose() {
    timer?.cancel(); // إيقاف المؤقت عند مغادرة الصفحة
    super.dispose();
  }

  // بدء العداد الزمني
  void startTimer() {
    timer?.cancel();
    timeLeft = 30;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() => timeLeft--);
      } else {
        endQuiz();
      }
    });
  }

  // تشغيل صوت الإجابة الصحيحة
  void _playClapSound() {
    final player = AudioPlayer();
    player.play(AssetSource('sound.mp3'));
  }

  // معالجة اختيار المستخدم للإجابة
  void answerQuestion(String selectedAnswer) {
    if (timer?.isActive ?? false) timer!.cancel();

    bool isCorrect =
        selectedAnswer == questions[currentQuestionIndex]['correctAnswer'];

    if (isCorrect) {
      setState(() => score++);
      _playClapSound(); // تشغيل الصوت عند الإجابة الصحيحة
    }

    Future.delayed(const Duration(milliseconds: 300), () {
      if (currentQuestionIndex < questions.length - 1) {
        setState(() {
          currentQuestionIndex++;
          startTimer(); // بدء العداد للسؤال التالي
        });
      } else {
        endQuiz(); // إنهاء اللعبة إذا انتهت الأسئلة
      }
    });
  }

  // إنهاء اللعبة وعرض النتيجة
  void endQuiz() {
    timer?.cancel();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ResultPage(score: score, totalQuestions: questions.length),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('السؤال ${currentQuestionIndex + 1}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('الوقت المتبقي: $timeLeft ثانية'),
            const SizedBox(height: 20),
            Text(
              questions[currentQuestionIndex]['question'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...questions[currentQuestionIndex]['answers']
                .map<Widget>((answer) => ElevatedButton(
                      onPressed: () => answerQuestion(answer),
                      child: Text(answer),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}

// صفحة النتيجة النهائية
class ResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ResultPage({super.key, required this.score, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('النتيجة')),
      body: Center(
        child: Text('نتيجتك: $score / $totalQuestions'),
      ),
    );
  }
}

// صفحة تشغيل الفيديو
class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مشاهدة الفيديو')),
      body: Center(child: VideoPlayer(_controller)),
    );
  }
}

// ignore: non_constant_identifier_names
VideoPlayer(controller) {
}
