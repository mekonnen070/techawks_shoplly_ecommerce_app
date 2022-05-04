class GetSchema {
  static String getCategoryQuery = """
 query{
  categories {
    categoryId
    name
    subCategories{
      categoryId
      subCategoryId
      name
    }
  }
}
""";

  static String productsQuery = """
     query products(\$categoryId: String!){
        products(categoryId: \$categoryId){
            productId
            name
            price
            discount
            description
            categoryId
            subCategoryId
            unitsSold
            createdAt
            images{
                url
            }
        }
    }
""";

  static String createOrderQuery = """
     mutation createOrder(\$input: OrderInput!){
        createOrder(input: \$input){
            orderId
            orderNumber
            deliveryDate
        }
    }
""";
}
