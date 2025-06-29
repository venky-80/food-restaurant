#!/bin/bash

# Setup script for React Native app "Vaarahi Grand Restaurant"

echo "Initializing React Native project..."
npx react-native init VaarahiGrandRestaurant --version 0.71.8

cd VaarahiGrandRestaurant || exit 1

echo "Creating directories..."
mkdir -p react_native_app/screens
mkdir -p react_native_app/services

echo "Writing source code files..."

# App.js
cat > react_native_app/App.js << 'EOF'
import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';

// Import screens
import LoginScreen from './screens/LoginScreen';
import SignupScreen from './screens/SignupScreen';
import MenuScreen from './screens/MenuScreen';
import CartScreen from './screens/CartScreen';
import OrdersScreen from './screens/OrdersScreen';
import AdminDashboard from './screens/AdminDashboard';
import AdminMenuManagement from './screens/AdminMenuManagement';

const Stack = createNativeStackNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName="Login" screenOptions={{ headerShown: false }}>
        {/* Authentication */}
        <Stack.Screen name="Login" component={LoginScreen} />
        <Stack.Screen name="Signup" component={SignupScreen} />

        {/* User Screens */}
        <Stack.Screen name="Menu" component={MenuScreen} />
        <Stack.Screen name="Cart" component={CartScreen} />
        <Stack.Screen name="Orders" component={OrdersScreen} />

        {/* Admin Screens */}
        <Stack.Screen name="AdminDashboard" component={AdminDashboard} />
        <Stack.Screen name="AdminMenuManagement" component={AdminMenuManagement} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}
EOF

# services/menuService.js
cat > react_native_app/services/menuService.js << 'EOF'
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
EOF

# screens/LoginScreen.js
cat > react_native_app/screens/LoginScreen.js << 'EOF'
import React, { useState } from 'react';
import { View, Text, TextInput, TouchableOpacity, StyleSheet, Alert } from 'react-native';

export default function LoginScreen({ navigation }) {
  const [emailOrPhone, setEmailOrPhone] = useState('');
  const [password, setPassword] = useState('');

  const handleLogin = () => {
    // TODO: Implement login logic with backend API
    if (emailOrPhone && password) {
      // For demo, navigate to Menu screen
      navigation.replace('Menu');
    } else {
      Alert.alert('Error', 'Please enter email/phone and password');
    }
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>🍽️ Vaarahi Grand Restaurant</Text>
      <Text style={styles.subtitle}>Login to Your Account</Text>

      <TextInput
        style={styles.input}
        placeholder="Email or Phone"
        value={emailOrPhone}
        onChangeText={setEmailOrPhone}
        keyboardType="email-address"
        autoCapitalize="none"
      />

      <TextInput
        style={styles.input}
        placeholder="Password"
        value={password}
        onChangeText={setPassword}
        secureTextEntry
      />

      <TouchableOpacity style={styles.button} onPress={handleLogin}>
        <Text style={styles.buttonText}>🔑 Login</Text>
      </TouchableOpacity>

      <View style={styles.footer}>
        <TouchableOpacity onPress={() => navigation.navigate('Signup')}>
          <Text style={styles.link}>📝 Sign Up</Text>
        </TouchableOpacity>
        <TouchableOpacity onPress={() => Alert.alert('Forgot Password', 'Forgot password flow to be implemented')}>
          <Text style={styles.link}>🔒 Forgot Password</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#fff',
    justifyContent: 'center',
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
    color: '#667eea',
    textAlign: 'center',
    marginBottom: 10,
  },
  subtitle: {
    fontSize: 18,
    color: '#333',
    textAlign: 'center',
    marginBottom: 20,
  },
  input: {
    borderWidth: 1,
    borderColor: '#667eea',
    borderRadius: 8,
    padding: 12,
    marginBottom: 15,
  },
  button: {
    backgroundColor: '#667eea',
    padding: 15,
    borderRadius: 8,
    alignItems: 'center',
    marginBottom: 15,
  },
  buttonText: {
    color: '#fff',
    fontWeight: 'bold',
    fontSize: 16,
  },
  footer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  link: {
    color: '#667eea',
    fontWeight: 'bold',
  },
});
EOF

# screens/SignupScreen.js
cat > react_native_app/screens/SignupScreen.js << 'EOF'
import React, { useState } from 'react';
import { View, Text, TextInput, TouchableOpacity, StyleSheet, Alert } from 'react-native';

export default function SignupScreen({ navigation }) {
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [phone, setPhone] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');

  const handleSignup = () => {
    // TODO: Implement signup logic with OTP verification
    if (!name || !email || !phone || !password || !confirmPassword) {
      Alert.alert('Error', 'Please fill all fields');
      return;
    }
    if (password !== confirmPassword) {
      Alert.alert('Error', 'Passwords do not match');
      return;
    }
    // For demo, navigate back to Login
    Alert.alert('Success', 'Signup successful! Please login.');
    navigation.replace('Login');
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>📝 Create New Account</Text>

      <TextInput
        style={styles.input}
        placeholder="Full Name"
        value={name}
        onChangeText={setName}
      />

      <TextInput
        style={styles.input}
        placeholder="Email"
        value={email}
        onChangeText={setEmail}
        keyboardType="email-address"
        autoCapitalize="none"
      />

      <TextInput
        style={styles.input}
        placeholder="Phone Number"
        value={phone}
        onChangeText={setPhone}
        keyboardType="phone-pad"
      />

      <TextInput
        style={styles.input}
        placeholder="Password"
        value={password}
        onChangeText={setPassword}
        secureTextEntry
      />

      <TextInput
        style={styles.input}
        placeholder="Confirm Password"
        value={confirmPassword}
        onChangeText={setConfirmPassword}
        secureTextEntry
      />

      <TouchableOpacity style={styles.button} onPress={handleSignup}>
        <Text style={styles.buttonText}>📝 Sign Up</Text>
      </TouchableOpacity>

      <View style={styles.footer}>
        <TouchableOpacity onPress={() => navigation.navigate('Login')}>
          <Text style={styles.link}>🔑 Back to Login</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#fff',
    justifyContent: 'center',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#667eea',
    textAlign: 'center',
    marginBottom: 20,
  },
  input: {
    borderWidth: 1,
    borderColor: '#667eea',
    borderRadius: 8,
    padding: 12,
    marginBottom: 15,
  },
  button: {
    backgroundColor: '#667eea',
    padding: 15,
    borderRadius: 8,
    alignItems: 'center',
    marginBottom: 15,
  },
  buttonText: {
    color: '#fff',
    fontWeight: 'bold',
    fontSize: 16,
  },
  footer: {
    alignItems: 'center',
  },
  link: {
    color: '#667eea',
    fontWeight: 'bold',
  },
});
EOF

# screens/MenuScreen.js
cat > react_native_app/screens/MenuScreen.js << 'EOF'
import React, { useState, useEffect } from 'react';
import { View, Text, FlatList, TextInput, TouchableOpacity, StyleSheet, Image, Alert } from 'react-native';
import { fetchMenuItems } from '../services/menuService';

export default function MenuScreen({ navigation }) {
  const [menuItems, setMenuItems] = useState([]);
  const [searchTerm, setSearchTerm] = useState('');
  const [categoryFilter, setCategoryFilter] = useState('All');
  const [typeFilter, setTypeFilter] = useState('All');
  const [filteredItems, setFilteredItems] = useState([]);

  useEffect(() => {
    const loadMenu = async () => {
      const items = await fetchMenuItems();
      setMenuItems(items);
    };
    loadMenu();
  }, []);

  useEffect(() => {
    filterAndSortItems();
  }, [searchTerm, categoryFilter, typeFilter, menuItems]);

  const filterAndSortItems = () => {
    let items = [...menuItems];

    if (searchTerm) {
      const lowerSearch = searchTerm.toLowerCase();
      items = items.filter(
        (item) =>
          item.name.toLowerCase().includes(lowerSearch) ||
          (item.description && item.description.toLowerCase().includes(lowerSearch))
      );
    }

    if (categoryFilter !== 'All') {
      items = items.filter((item) => item.category === categoryFilter);
    }

    if (typeFilter !== 'All') {
      if (typeFilter === 'Veg') {
        items = items.filter((item) => item.type === 'veg');
      } else if (typeFilter === 'Non-Veg') {
        items = items.filter((item) => item.type === 'non-veg');
      }
    }

    setFilteredItems(items);
  };

  // Extract unique categories from menuItems for filter options
  const categories = ['All', ...Array.from(new Set(menuItems.map(item => item.category)))];

  return (
    <View style={styles.container}>
      <Text style={styles.title}>📋 Our Delicious Menu</Text>

      <TextInput
        style={styles.searchInput}
        placeholder="🔍 Search Menu"
        value={searchTerm}
        onChangeText={setSearchTerm}
      />

      <View style={styles.filters}>
        <FlatList
          horizontal
          data={categories}
          keyExtractor={(item) => item}
          renderItem={({ item }) => (
            <TouchableOpacity
              style={[
                styles.filterButton,
                categoryFilter === item && styles.filterButtonActive,
              ]}
              onPress={() => setCategoryFilter(item)}
            >
              <Text
                style={[
                  styles.filterText,
                  categoryFilter === item && styles.filterTextActive,
                ]}
              >
                {item}
              </Text>
            </TouchableOpacity>
          )}
          showsHorizontalScrollIndicator={false}
        />

        <View style={styles.typeFilters}>
          <TouchableOpacity
            style={[
              styles.filterButton,
              typeFilter === 'All' && styles.filterButtonActive,
            ]}
            onPress={() => setTypeFilter('All')}
          >
            <Text
              style={[
                styles.filterText,
                typeFilter === 'All' && styles.filterTextActive,
              ]}
            >
              All
            </Text>
          </TouchableOpacity>
          <TouchableOpacity
            style={[
              styles.filterButton,
              typeFilter === 'Veg' && styles.filterButtonActive,
            ]}
            onPress={() => setTypeFilter('Veg')}
          >
            <Text
              style={[
                styles.filterText,
                typeFilter === 'Veg' && styles.filterTextActive,
              ]}
            >
              🥬 Veg
            </Text>
          </TouchableOpacity>
          <TouchableOpacity
            style={[
              styles.filterButton,
              typeFilter === 'Non-Veg' && styles.filterButtonActive,
            ]}
            onPress={() => setTypeFilter('Non-Veg')}
          >
            <Text
              style={[
                styles.filterText,
                typeFilter === 'Non-Veg' && styles.filterTextActive,
              ]}
            >
              🍖 Non-Veg
            </Text>
          </TouchableOpacity>
        </View>
      </View>

      <FlatList
        data={filteredItems}
        keyExtractor={(item) => item.id}
        renderItem={({ item }) => (
          <TouchableOpacity
            style={styles.menuItemCard}
            onPress={() => Alert.alert(item.name, item.description)}
          >
            <Image
              source={{ uri: item.image || 'https://via.placeholder.com/120' }}
              style={styles.menuItemImage}
              resizeMode="cover"
            />
            <View style={styles.menuItemContent}>
              <Text style={styles.menuItemName}>
                {item.popular ? '⭐ ' : ''}
                {item.name}
              </Text>
              <Text style={styles.menuItemType}>
                {item.type === 'veg' ? '🥬 Veg' : '🍖 Non-Veg'}
              </Text>
              <Text style={styles.menuItemDescription} numberOfLines={2}>
                {item.description}
              </Text>
              <Text style={styles.menuItemPrice}>₹{item.price}</Text>
            </View>
          </TouchableOpacity>
        )}
        contentContainerStyle={{ paddingBottom: 100 }}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 10,
    backgroundColor: '#fff',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#667eea',
    marginBottom: 10,
    textAlign: 'center',
  },
  searchInput: {
    borderWidth: 1,
    borderColor: '#667eea',
    borderRadius: 8,
    padding: 10,
    marginBottom: 10,
  },
  filters: {
    marginBottom: 10,
  },
  filterButton: {
    paddingVertical: 6,
    paddingHorizontal: 12,
    borderRadius: 20,
    borderWidth: 1,
    borderColor: '#667eea',
    marginRight: 8,
  },
  filterButtonActive: {
    backgroundColor: '#667eea',
  },
  filterText: {
    color: '#667eea',
    fontWeight: 'bold',
  },
  filterTextActive: {
    color: '#fff',
  },
  typeFilters: {
    flexDirection: 'row',
    marginTop: 8,
  },
  menuItemCard: {
    flexDirection: 'row',
    backgroundColor: '#fff',
    borderRadius: 12,
    marginBottom: 10,
    elevation: 2,
    shadowColor: '#000',
    shadowOpacity: 0.1,
    shadowRadius: 4,
    shadowOffset: { width: 0, height: 2 },
    overflow: 'hidden',
  },
  menuItemImage: {
    width: 120,
    height: 120,
  },
  menuItemContent: {
    flex: 1,
    padding: 10,
    justifyContent: 'space-between',
  },
  menuItemName: {
    fontSize: 16,
    fontWeight: 'bold',
  },
  menuItemType: {
    fontSize: 12,
    color: '#888',
    marginVertical: 4,
  },
  menuItemDescription: {
    fontSize: 14,
    color: '#444',
  },
  menuItemPrice: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#222',
  },
});
EOF

# screens/CartScreen.js
cat > react_native_app/screens/CartScreen.js << 'EOF'
import React, { useState } from 'react';
import { View, Text, FlatList, TouchableOpacity, StyleSheet, Alert } from 'react-native';

const sampleCartItems = [
  {
    id: '1',
    name: 'Chicken Biryani (Regular)',
    price: 250,
    quantity: 2,
  },
  {
    id: '2',
    name: 'Paneer Butter Masala',
    price: 180,
    quantity: 1,
  },
];

export default function CartScreen({ navigation }) {
  const [cartItems, setCartItems] = useState(sampleCartItems);

  const increaseQuantity = (id) => {
    const updatedCart = cartItems.map((item) =>
      item.id === id ? { ...item, quantity: item.quantity + 1 } : item
    );
    setCartItems(updatedCart);
  };

  const decreaseQuantity = (id) => {
    const updatedCart = cartItems
      .map((item) =>
        item.id === id ? { ...item, quantity: item.quantity - 1 } : item
      )
      .filter((item) => item.quantity > 0);
    setCartItems(updatedCart);
  };

  const getTotal = () => {
    return cartItems.reduce((sum, item) => sum + item.price * item.quantity, 0);
  };

  const handleCheckout = () => {
    if (cartItems.length === 0) {
      Alert.alert('Cart is empty', 'Please add items to cart before checkout.');
      return;
    }
    // TODO: Implement checkout flow
    Alert.alert('Checkout', 'Checkout flow to be implemented.');
  };

  const renderItem = ({ item }) => (
    <View style={styles.cartItem}>
      <Text style={styles.itemName}>{item.name}</Text>
      <View style={styles.controls}>
        <TouchableOpacity
          style={styles.controlButton}
          onPress={() => decreaseQuantity(item.id)}
        >
          <Text style={styles.controlButtonText}>➖</Text>
        </TouchableOpacity>
        <Text style={styles.quantity}>{item.quantity}</Text>
        <TouchableOpacity
          style={styles.controlButton}
          onPress={() => increaseQuantity(item.id)}
        >
          <Text style={styles.controlButtonText}>➕</Text>
        </TouchableOpacity>
      </View>
      <Text style={styles.itemPrice}>₹{item.price * item.quantity}</Text>
    </View>
  );

  return (
    <View style={styles.container}>
      <Text style={styles.title}>🛒 Shopping Cart</Text>

      {cartItems.length === 0 ? (
        <Text style={styles.emptyText}>Your cart is empty.</Text>
      ) : (
        <FlatList
          data={cartItems}
          keyExtractor={(item) => item.id}
          renderItem={renderItem}
          contentContainerStyle={{ paddingBottom: 100 }}
        />
      )}

      <View style={styles.summary}>
        <Text style={styles.totalText}>Total: ₹{getTotal()}</Text>
        <TouchableOpacity style={styles.checkoutButton} onPress={handleCheckout}>
          <Text style={styles.checkoutButtonText}>🚀 Proceed to Checkout</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 10,
    backgroundColor: '#fff',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#667eea',
    marginBottom: 10,
    textAlign: 'center',
  },
  emptyText: {
    fontSize: 16,
    color: '#888',
    textAlign: 'center',
    marginTop: 50,
  },
  cartItem: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#f8f9fa',
    borderRadius: 12,
    padding: 10,
    marginBottom: 10,
  },
  itemName: {
    flex: 2,
    fontSize: 16,
  },
  controls: {
    flexDirection: 'row',
    alignItems: 'center',
    flex: 1,
    justifyContent: 'center',
  },
  controlButton: {
    backgroundColor: '#667eea',
    borderRadius: 6,
    padding: 6,
    marginHorizontal: 5,
  },
  controlButtonText: {
    color: '#fff',
    fontSize: 18,
    fontWeight: 'bold',
  },
  quantity: {
    fontSize: 16,
    fontWeight: 'bold',
  },
  itemPrice: {
    flex: 1,
    fontSize: 16,
    fontWeight: 'bold',
    textAlign: 'right',
  },
  summary: {
    position: 'absolute',
    bottom: 0,
    left: 0,
    right: 0,
    backgroundColor: '#fff',
    padding: 15,
    borderTopWidth: 1,
    borderColor: '#ddd',
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  totalText: {
    fontSize: 18,
    fontWeight: 'bold',
  },
  checkoutButton: {
    backgroundColor: '#667eea',
    paddingVertical: 10,
    paddingHorizontal: 20,
    borderRadius: 8,
  },
  checkoutButtonText: {
    color: '#fff',
    fontWeight: 'bold',
    fontSize: 16,
  },
});
EOF

# screens/OrdersScreen.js
cat > react_native_app/screens/OrdersScreen.js << 'EOF'
import React from 'react';
import { View, Text, FlatList, StyleSheet, TouchableOpacity, Alert } from 'react-native';

const sampleOrders = [
  {
    id: 'order1',
    status: 'pending',
    total: 680,
    customerName: 'John Doe',
    timestamp: '2024-06-01T12:30:00',
  },
  {
    id: 'order2',
    status: 'delivered',
    total: 450,
    customerName: 'Jane Smith',
    timestamp: '2024-05-30T18:45:00',
  },
];

const statusColors = {
  pending: '#ffc107',
  confirmed: '#007bff',
  preparing: '#fd7e14',
  ready: '#28a745',
  delivered: '#20c997',
  cancelled: '#dc3545',
};

export default function OrdersScreen() {
  const renderOrder = ({ item }) => (
    <TouchableOpacity
      style={[styles.orderCard, { borderLeftColor: statusColors[item.status] || '#6c757d' }]}
      onPress={() => Alert.alert(`Order #${item.id}`, `Status: ${item.status}\nTotal: ₹${item.total}`)}
    >
      <View style={styles.orderInfo}>
        <Text style={styles.orderId}>Order #{item.id.slice(0, 8)}</Text>
        <Text style={styles.customerName}>{item.customerName}</Text>
      </View>
      <View style={styles.orderDetails}>
        <Text style={styles.orderStatus}>{item.status.toUpperCase()}</Text>
        <Text style={styles.orderTotal}>₹{item.total}</Text>
      </View>
    </TouchableOpacity>
  );

  return (
    <View style={styles.container}>
      <Text style={styles.title}>📦 My Orders</Text>

      {sampleOrders.length === 0 ? (
        <Text style={styles.emptyText}>You haven't placed any orders yet.</Text>
      ) : (
        <FlatList
          data={sampleOrders}
          keyExtractor={(item) => item.id}
          renderItem={renderOrder}
          contentContainerStyle={{ paddingBottom: 100 }}
        />
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 10,
    backgroundColor: '#fff',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#667eea',
    marginBottom: 10,
    textAlign: 'center',
  },
  emptyText: {
    fontSize: 16,
    color: '#888',
    textAlign: 'center',
    marginTop: 50,
  },
  orderCard: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    backgroundColor: '#f8f9fa',
    borderLeftWidth: 6,
    borderRadius: 8,
    padding: 15,
    marginBottom: 10,
  },
  orderInfo: {
    flex: 2,
  },
  orderId: {
    fontSize: 16,
    fontWeight: 'bold',
  },
  customerName: {
    fontSize: 14,
    color: '#555',
  },
  orderDetails: {
    flex: 1,
    alignItems: 'flex-end',
  },
  orderStatus: {
    fontSize: 14,
    fontWeight: 'bold',
    marginBottom: 5,
  },
  orderTotal: {
    fontSize: 16,
    fontWeight: 'bold',
  },
});
EOF

# screens/AdminDashboard.js
cat > react_native_app/screens/AdminDashboard.js << 'EOF'
import React from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, Alert } from 'react-native';

export default function AdminDashboard({ navigation }) {
  // Sample metrics data - replace with API calls
  const metrics = {
    totalRevenue: 125000,
    totalOrders: 350,
    pendingOrders: 12,
    avgOrderValue: 357,
    totalUsers: 120,
    menuItems: 45,
    completedOrders: 320,
    successRate: 91.4,
  };

  return (
    <ScrollView style={styles.container}>
      <Text style={styles.title}>👨‍💼 Admin Dashboard</Text>

      <View style={styles.metricsRow}>
        <View style={styles.metricCard}>
          <Text style={styles.metricValue}>₹{metrics.totalRevenue}</Text>
          <Text style={styles.metricLabel}>Total Revenue</Text>
        </View>
        <View style={styles.metricCard}>
          <Text style={styles.metricValue}>{metrics.totalOrders}</Text>
          <Text style={styles.metricLabel}>Total Orders</Text>
        </View>
      </View>

      <View style={styles.metricsRow}>
        <View style={styles.metricCard}>
          <Text style={styles.metricValue}>{metrics.pendingOrders}</Text>
          <Text style={styles.metricLabel}>Pending Orders</Text>
        </View>
        <View style={styles.metricCard}>
          <Text style={styles.metricValue}>₹{metrics.avgOrderValue}</Text>
          <Text style={styles.metricLabel}>Avg Order Value</Text>
        </View>
      </View>

      <View style={styles.metricsRow}>
        <View style={styles.metricCard}>
          <Text style={styles.metricValue}>{metrics.totalUsers}</Text>
          <Text style={styles.metricLabel}>Total Users</Text>
        </View>
        <View style={styles.metricCard}>
          <Text style={styles.metricValue}>{metrics.menuItems}</Text>
          <Text style={styles.metricLabel}>Menu Items</Text>
        </View>
      </View>

      <View style={styles.metricsRow}>
        <View style={styles.metricCard}>
          <Text style={styles.metricValue}>{metrics.completedOrders}</Text>
          <Text style={styles.metricLabel}>Completed Orders</Text>
        </View>
        <View style={styles.metricCard}>
          <Text style={styles.metricValue}>{metrics.successRate}%</Text>
          <Text style={styles.metricLabel}>Success Rate</Text>
        </View>
      </View>

      <View style={styles.buttonsContainer}>
        <TouchableOpacity
          style={styles.button}
          onPress={() => navigation.navigate('AdminMenuManagement')}
        >
          <Text style={styles.buttonText}>📋 Menu Management</Text>
        </TouchableOpacity>

        <TouchableOpacity
          style={styles.button}
          onPress={() => Alert.alert('Order Management', 'To be implemented')}
        >
          <Text style={styles.buttonText}>📦 Order Management</Text>
        </TouchableOpacity>

        <TouchableOpacity
          style={styles.button}
          onPress={() => Alert.alert('User Management', 'To be implemented')}
        >
          <Text style={styles.buttonText}>👥 User Management</Text>
        </TouchableOpacity>
      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 15,
    backgroundColor: '#fff',
  },
  title: {
    fontSize: 26,
    fontWeight: 'bold',
    color: '#667eea',
    marginBottom: 20,
    textAlign: 'center',
  },
  metricsRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 15,
  },
  metricCard: {
    flex: 1,
    backgroundColor: '#f8f9fa',
    borderRadius: 12,
    padding: 15,
    marginHorizontal: 5,
    alignItems: 'center',
  },
  metricValue: {
    fontSize: 22,
    fontWeight: 'bold',
    color: '#222',
  },
  metricLabel: {
    fontSize: 14,
    color: '#555',
    marginTop: 5,
  },
  buttonsContainer: {
    marginTop: 30,
  },
  button: {
    backgroundColor: '#667eea',
    padding: 15,
    borderRadius: 12,
    marginBottom: 15,
    alignItems: 'center',
  },
  buttonText: {
    color: '#fff',
    fontWeight: 'bold',
    fontSize: 16,
  },
});
EOF

echo "Installing dependencies..."
npm install @react-navigation/native @react-navigation/native-stack react-native-screens react-native-safe-area-context react-native-gesture-handler react-native-reanimated

echo "Setup complete. To run the app, use:"
echo "cd VaarahiGrandRestaurant"
echo "npx react-native run-android # or run-ios"
EOF
