let menuItems = [
  {
    id: 'local_001',
    name: 'Paneer Butter Masala',
    price: 229,
    type: 'veg',
    category: 'Main Course',
    description: 'Creamy tomato gravy with soft paneer cubes.',
    image: '',
    availability: 'Available',
    popular: true,
    pricing_options: null,
  },
];

// Simulate async fetch of menu items
export const fetchMenuItems = async () => {
  // In real app, fetch from backend or local storage
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve(menuItems);
    }, 500);
  });
};

// Simulate async save of menu items
export const saveMenuItems = async (items) => {
  return new Promise((resolve) => {
    setTimeout(() => {
      menuItems = items;
      resolve(true);
    }, 500);
  });
};
