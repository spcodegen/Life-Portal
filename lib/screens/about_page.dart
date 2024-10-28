import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  void _launchURL(String url) async {
    launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text("About Page"),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Container(
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          "About Us",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Georgia',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildTile(
                        title: "Co-operative Insurance Company PLC",
                        content:
                            "Incorporated in Sri Lanka in 1999. Licensed as a company authorized to carry out insurance business under the Control of Insurance Act No. 25 of 1962 as amended by Act No. 42 of 1986 (presently replaced by Regulation of Insurance Industry Act No. 43 of 2000). We are one of the leading insurers who provide innovative insurance solutions across all lines of business, with the third-largest network in Sri Lanka.",
                      ),
                      _buildTile(
                        title: "History",
                        content:
                            "In 1999, Co-operative Insurance Company PLC (CICPLC) was established by the co-operative movement with great prospects. More than 2 decades and numerous challenges later, CICPLC is one of the largest and fastest-growing companies in Sri Lanka.\n\nAs a customer-centric and people-driven organization, we inspire our stakeholders to be proactive and innovative. Our utmost convenient solutions set us apart from other orthodox entities in the industry.",
                      ),
                      _buildTile(
                        title: "Vision",
                        content:
                            "“To be an organization that will stand 'united' with its customers to the very end.”",
                      ),
                      _buildTile(
                        title: "Mission",
                        content:
                            "“To be ever mindful of the needs of our customers and thereby make 'true protection' via the provision of innovative, yet affordable insurance solutions which conform to the highest ethical and moral standards.”",
                      ),
                      _buildTile(
                        title: "Values",
                        content:
                            "R - Respect - Respectful when REACT\nE - Ethical - Ethical when REACT\nA - Accountable - Accountable when REACT\nC - Commitment - Committed when REACT\nT - Trust - Trustworthy when REACT",
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 16,
                  bottom: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildSocialButton('assets/youtube.png', () async {
                        launch(
                            'https://www.youtube.com/channel/UC6-Ex5c_AFfBi7mJxP6dsIw');
                      }),
                      SizedBox(height: 16),
                      _buildSocialButton(
                        'assets/linkedin.png',
                        () async {
                          launch(
                              'https://www.linkedin.com/company/co-operative-insurance/');
                        },
                      ),
                      SizedBox(height: 16),
                      _buildSocialButton(
                        'assets/facebook.png',
                        () async {
                          launch(
                              'https://www.facebook.com/Coperativeinsurance/');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTile({required String title, required String content}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white.withOpacity(0.8),
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontFamily: 'Georgia',
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 68, 124),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Georgia',
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(String iconPath, VoidCallback onPressed) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.white,
      shape: const CircleBorder(),
      elevation: 5,
      child: Image.asset(
        iconPath,
        fit: BoxFit.contain,
        width: 30,
        height: 30,
      ),
    );
  }
}
