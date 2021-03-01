class CategoriesConstant {
  static const GROCERY = 'GROCERY';
  static const HOUSEHOLD_ITEMS = 'HOUSEHOLD_ITEMS';
  static const PERSONAL_CARE = 'PERSONAL_CARE';
  static const FRUITS_AND_VEGETABLE = 'FRUITS_AND_VEGETABLE';
  static const BEVERAGES = 'BEVERAGES';
  static const BREAKFAST_AND_DAIRY = 'BREAKFAST_AND_DAIRY';
  static const INSTANT_FOOD = 'INSTANT_FOOD';
  static const CHOCOLATES_AND_ICE_CREAM = 'CHOCOLATES_AND_ICE-CREAM';
  static const BISCUTE_AND_SNACK = 'BISCUTE_AND_SNACK';

  static const SUBCATEGORIES = 'subcategories';
  static const NAME = 'name';

  static const Map<String, Map<String, dynamic>> CATEGORY_CONSTANTS = {
    GROCERY: {
      NAME: 'Grocery',
      SUBCATEGORIES: {
        'grocery#aata#sid': 'Atta',
        'grocery#dryfruits#sid': 'Dry Fruits',
        'grocery#ghee_vanaspati#sid': 'Ghee & Vanaspati',
        'grocery#edible_oils#sid': 'Edible Oils',
        'grocery#pulses#sid': 'Pulses',
        'grocery#rice_grains#sid': 'Rice & Grains',
        'grocery#salt_sugar#sid': 'Salt & Sugar',
        'grocery#spices#sid': 'Spices',
        // 'grocery#sauces_ketchups#sid': 'Sauces & Ketchups'
      }
    },
    HOUSEHOLD_ITEMS: {
      NAME: 'Household Items',
      SUBCATEGORIES: {
        'household#detergents#sid': 'Detergents',
        'household#cleaners#sid': 'Cleaners',
        'household#disinfectantss#sid': 'Disinfectants',
        'household#air_fresheners#sid': 'Air Fresheners',
        'household#repellents#sid': 'Repellents',
        'household#dishwash#sid': 'Dishwash'
      }
    },
    PERSONAL_CARE: {
      NAME: 'Personal Care',
      SUBCATEGORIES: {
        'personal_care#hair_oil#sid': 'Hair Oil',
        'personal_care#shampoo#sid': 'Shampoo',
        'personal_care#soap_bodywash#sid': 'Soap & Body Wash',
        'personal_care#toothpaste#sid': 'Toothpaste',
        'personal_care#handwash#sid': 'Hand Wash',
        'personal_care#sanitary_pads#sid': 'Sanitary Pads',
        'personal_care#bodylotions#sid': 'Body Lotions',
        'personal_care#face_wash#sid': 'Face Wash',
        'personal_care#fragrance#sid': 'Fragrance'
      }
    },
    FRUITS_AND_VEGETABLE: {
      NAME: 'Fruits & vegetable',
      SUBCATEGORIES: {
        'fruit_vegetable#fruits#sid': 'Fruits',
        'fruit_vegetable#vegetable#sid': 'Vegetable',
      }
    },
    BEVERAGES: {
      NAME: 'Beverages',
      SUBCATEGORIES: {
        'beverages#tea#sid': 'Tea',
        'beverages#green_tea#sid': 'Green tea',
        'beverages#coffee#sid': 'Coffee',
        'beverages#health_drinks#sid': 'Health Drinks',
        'beverages#cold_drinks#sid': 'Cold Drinks',
        'beverages#juices#sid': 'Juices',
      }
    },
    BREAKFAST_AND_DAIRY: {
      NAME: 'Breakfast & Dairy',
      SUBCATEGORIES: {
        'breakfast_dairy#butter_cheese#sid': 'Butter & Cheese',
        'breakfast_dairy#bread_eggs#sid': 'Bread & Eggs',
        'breakfast_dairy#milk#sid': 'Milk',
        'breakfast_dairy#breakfast_cereals#sid': 'Breakfast Cereals',
        'breakfast_dairy#paneer_curd#sid': 'Paneer & Curd',
        // 'breakfast_dairy#tea_cofee#sid': 'Tea & Coffee',
        'breakfast_dairy#eggs#sid': 'Eggs',
      }
    },
    INSTANT_FOOD: {
      NAME: 'Instant Food',
      SUBCATEGORIES: {
        // 'instant_food#biscuits_cookies#sid': 'Biscuits & Cookies',
        // 'instant_food#chocolates_candies#sid': 'Chocolates & Candies',
        'instant_food#noodles_pasta#sid': 'Noodles & Pasta',
        'instant_food#pickeles_sauces#sid': 'Pickles & Sauces',
        'instant_food#jam_spreads#sid': 'Jam & Ketchups',
        'instant_food#sweets#sid': 'Sweets',
      }
    },
    CHOCOLATES_AND_ICE_CREAM: {
      NAME: 'Chocolates & Ice Cream',
      SUBCATEGORIES: {
        'choco_icecream#bar_choco#sid': 'Bar Chocolates',
        'choco_icecream#tofees_lollipops#sid': 'Tofees & Lollipops',
        'choco_icecream#mint_chewinggum#sid': 'Mints & Chewing Gums',
        'choco_icecream#icecreams#sid': 'Ice Creams',
      }
    },
    BISCUTE_AND_SNACK: {
      NAME: 'Biscute & Snack',
      SUBCATEGORIES: {
        'biscute_snack#namkeen_chips#sid': 'Namkeen & Chips',
        'instant_food#biscuits_cookies#sid': 'Biscuits & Cookies',
      }
    }
  };

  static const BASIC_LIST = {
    GROCERY: [
      'Atta',
      'Dry Fruits',
      'Ghee & Vanaspati',
      'Edible Oils',
      'Pulses',
      'Rice & Grains',
      'Salt & Sugar',
      'Spices',
      'Sauces & Ketchups'
    ],
    HOUSEHOLD_ITEMS: [
      'Detergents',
      'Cleaners',
      'Disinfectants',
      'Air Fresheners',
      'Repellents',
      'Dishwash Gel'
    ],
    PERSONAL_CARE: [
      'Hair Oil',
      'Shampoo',
      'Soap & Body Wash',
      'Toothpaste',
      'Hand Wash',
      'Sanitary Pads',
      'Body Lotions',
      'Face Wash',
      'Fragrance'
    ],
    FRUITS_AND_VEGETABLE: ['Vegetables', 'Fruits'],
    BEVERAGES: [
      'Tea',
      'Green tea',
      'Coffee',
      'Health Drinks',
      'Cold Drinks',
      'Juices',
    ],
    BREAKFAST_AND_DAIRY: [
      'Butter & Cheese',
      'Break & Eggs',
      'Milk',
      'Breakfast Cereals',
      'Paneer & Curd',
      'Tea & Coffee',
      'Eggs'
    ],
    INSTANT_FOOD: [
      'Biscuits & Cookies',
      'Chocolates & Candies',
      'Namkeen & Chips',
      'Noodles & Pasta',
      'Pickles & Sauces',
      'Jam & Spreads',
      'Sweets'
    ],
    CHOCOLATES_AND_ICE_CREAM: [
      'Bar Chocolates',
      'Tofees & Lollipops',
      'Mints & Chewing Gums',
      'Ice Creams'
    ],
  };
}

// 8 Categories , 50 Sub-Categories
