import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jyothi_labs/view/screens/cart_screen.dart';
import 'package:provider/provider.dart';
import 'package:jyothi_labs/model/products.dart';
import 'package:jyothi_labs/view/widgets/quantity.dart';
import 'package:jyothi_labs/view_model/provider/quantity.dart';
import 'package:jyothi_labs/view_model/repos/products.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<AllProductsModel>> allCategories;
  AllProducts allProducts = AllProducts();

  @override
  void initState() {
    super.initState();
    allCategories = allProducts.fetchAllProdocts();

    allCategories.then((categories) {
      // Log the number of categories for debugging
      print("Number of categories: ${categories.length}");
      context.read<QuantityCount>().initializeQuantities(categories.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    int totalQuantity = context.watch<QuantityCount>().quantities.isNotEmpty
        ? context.watch<QuantityCount>().quantities.reduce((a, b) => a + b)
        : 0; // Default to 0 if the list is empty

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Products',
            style: GoogleFonts.mulish(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: Colors.white,
            ),
          ),
        ),
        body: FutureBuilder<List<AllProductsModel?>>(
          future: allCategories,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData && snapshot.data != null) {
              final categories = snapshot.data!;
              return Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: GridView.builder(
                      itemCount: categories.length,
                      padding: EdgeInsets.all(4),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1.8,
                      ),
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return Card(
                          color: Colors.white,
                          elevation: 2,
                          child: Container(
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 20, left: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: screenHeight * 0.16,
                                        width: screenWidth * 0.28,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image:
                                                NetworkImage(category!.image),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: category.image,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.error,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: screenHeight * 0.5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  category.name,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            '',
                                            style: TextStyle(
                                              fontSize: screenHeight * 0.020,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '60,00',
                                                style: TextStyle(
                                                  fontSize:
                                                      screenHeight * 0.022,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                '20% OFF',
                                                style: TextStyle(
                                                  color: Colors.teal,
                                                  fontSize:
                                                      screenHeight * 0.018,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Text(
                                                'XL/Beige',
                                                style: TextStyle(
                                                  fontSize:
                                                      screenHeight * 0.018,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                'Qty:',
                                                style: TextStyle(
                                                  color: Colors.teal,
                                                  fontSize:
                                                      screenHeight * 0.018,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              QuantityWidget(
                                                icon: Icons.remove,
                                                onpressed: () {
                                                  context
                                                      .read<QuantityCount>()
                                                      .decrement(index);
                                                },
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                context
                                                    .watch<QuantityCount>()
                                                    .quantities[index]
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize:
                                                      screenHeight * 0.018,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              QuantityWidget(
                                                icon: Icons.add,
                                                onpressed: () {
                                                  context
                                                      .read<QuantityCount>()
                                                      .increment(index);
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total Quantity:'),
                                Text(
                                  '$totalQuantity',
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.022,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SelectedQuantityListScreen(
                                      totalQuantity: totalQuantity.toString(),
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                minimumSize: Size(double.infinity, 60),
                              ),
                              child: Text(
                                'CHECKOUT',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenHeight * 0.018,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: Text('No data Available'));
            }
          },
        ),
      ),
    );
  }
}
