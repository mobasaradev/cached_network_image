import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final customCacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 1),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Images Collection',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            iconSize: 38,
            onPressed: clearCache,
            icon: const Icon(
              Icons.change_circle,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.separated(
          itemCount: 1000,
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  key: UniqueKey(),
                  imageUrl: "https://source.unsplash.com/random?sig=$index",
                  maxHeightDiskCache: 400,
                  // Placeholder
                  placeholder: (context, url) => const SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                        backgroundColor: Colors.black,
                      ),
                    ),
                  ),
                  // Image Builder
                  imageBuilder: (context, imageProvider) => Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Random Image",
                        style: TextStyle(
                          letterSpacing: 3,
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          shadows: <Shadow>[
                            Shadow(
                              color: Colors.orange,
                              offset: Offset(1, 0),
                              blurRadius: 1,
                            ),
                            Shadow(
                              color: Colors.red,
                              offset: Offset(0, 1),
                              blurRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // error
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error_outline,
                    size: 32,
                    color: Colors.grey,
                  ),
                  // cache manage
                  cacheManager: customCacheManager,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void clearCache() {
    DefaultCacheManager().emptyCache();
    imageCache.clear();
    imageCache.clearLiveImages();
    setState(() {});
  }
}


// https://images.pexels.com/photos/18003658/pexels-photo-18003658/free-photo-of-i-am-on-the-top-of-world-view-from-250m-apartment.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1