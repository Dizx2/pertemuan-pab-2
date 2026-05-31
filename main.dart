import 'package:flutter/material.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Praktikum PAB - Movie App',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xFFE50914), // Netflix Red
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // List halaman: Sekarang index ke-2 mengarah ke ProfileScreen asli
  final List<Widget> _pages = [
    const HomeScreen(),
    const DetailScreen(),
    const ProfileScreen(), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.black,
        selectedItemColor: const Color(0xFFE50914),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_max), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.movie_creation_outlined), label: "Movie"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }
}

// ==========================================
// HALAMAN 1: HOME (GRID POSTER)
// ==========================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PRAKTIKUM PAB", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailScreen())),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[900],
                image: DecorationImage(
                  image: NetworkImage('https://picsum.photos/seed/${index + 100}/400/600'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ==========================================
// HALAMAN 2: DETAIL (FIXED SCROLL & PLAY)
// ==========================================
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PRAKTIKUM PAB", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView( 
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 400,
                width: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(color: Colors.white.withOpacity(0.05), blurRadius: 10, spreadRadius: 2)
                  ],
                  image: const DecorationImage(
                    image: NetworkImage('https://picsum.photos/seed/movie_hd/600/900'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              const Text("Interstellar: Redux", textAlign: TextAlign.center, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text("Sci-Fi • Adventure • 2h 49m", style: TextStyle(color: Colors.grey, fontSize: 14)),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE50914),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 56),
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Memutar Film...")),
                  );
                },
                icon: const Icon(Icons.play_arrow_rounded, size: 30),
                label: const Text("Play", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// HALAMAN 3: PROFILE (NEWLY IMPLEMENTED)
// ==========================================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color netflixRed = Color(0xFFE50914);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1)),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Bagian Atas: Lingkaran Dekoratif & Avatar (Mengikuti pola geometri wireframe)
            Stack(
              alignment: Alignment.center,
              children: [
                // Efek pancaran warna merah di background atas
                Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [netflixRed.withOpacity(0.25), Colors.transparent],
                    ),
                  ),
                ),
                // Bingkai Avatar Bulat Merah
                Positioned(
                  top: 15,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: netflixRed,
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.grey[900],
                      child: const Icon(
                        Icons.person_outline_rounded,
                        size: 65,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // 2. Bagian Tengah: List Informasi Profil (Sesuai Isian Contoh Gambar)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF121212), // Dark grey panel
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[900]!, width: 1),
                ),
                child: Column(
                  children: [
                    _buildProfileTile(Icons.account_circle_outlined, "PAB 2026"),
                    _buildDivider(),
                    _buildProfileTile(Icons.phone_outlined, "146210012345"),
                    _buildDivider(),
                    _buildProfileTile(Icons.mail_outline_rounded, "pab2026@gmail.com"),
                    _buildDivider(),
                    _buildProfileTile(Icons.location_on_outlined, "Sidoarjo"),
                    _buildDivider(),
                    _buildProfileTile(Icons.camera_alt_outlined, "pab2026"), // Instagram / Sosmed
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // 3. Bagian Bawah: Dekorasi Melengkung Bawah (Glow effect penyeimbang layout)
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, netflixRed.withOpacity(0.1)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget untuk Baris Informasi Profil
  Widget _buildProfileTile(IconData icon, String dataText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFE50914), size: 26),
          const SizedBox(width: 20),
          Text(
            dataText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  // Garis Pembatas Antar Baris yang Halus
  Widget _buildDivider() {
    return Divider(
      color: Colors.grey[900],
      height: 1,
      thickness: 1,
      indent: 20,
      endIndent: 20,
    );
  }
}