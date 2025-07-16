# 1. Godot Outline & Resize Shader

### 📝 Description

Many games use visual indicators to show when an object is selected or can be interacted with.  
In this challenge, I created a **2D shader** in **Godot** to handle this effect purely through shader code.  
The shader does two things:

- Adds an **outline** around the object to make it stand out.
- Slightly **resizes** the object when a toggle is enabled, creating a pop effect.

This helps make interactable objects clear and visually appealing.

### 🧩 Solution

**Outline:**

- In the **fragment shader**, I check if the current pixel is transparent (under a certain threshold).
- If it is, I sample the neighboring pixels.
- If any neighbor is opaque (over a certain threshold), I draw that pixel with the **outline color**, creating the outline effect.

**Resize:**

- In the **vertex shader**, I slightly increase the vertex positions outward to scale up the sprite when the toggle is on.

### 🎥 Demo / Video Link

https://github.com/user-attachments/assets/b7f53b98-2a5f-4dbe-b15e-cf24720eccf0

# 2. Godot Enchantment Shine Shader

### 📝 Description

Many games use visual indicators to show when an item is enchanted, enhanced, or magical.  
In this challenge, I created a **2D shader** in **Godot** to replicate a Minecraft-style enchantment effect purely through shader code.  
The shader does two things:

- Adds a **tint** effect that multiplies a color with the pixel color and uses a subtle breathing animation to make the tint pulse over time.
- Adds a **glint** effect that moves a diagonal shine across the sprite, making it look shiny and enchanted.

This is a simple way to highlight an item and show that it’s special.

### 🧩 Solution

**Tint:**

- Uses a sine wave to make the tint strength pulse, multiplying this with the original pixel color to create a subtle breathing effect.

**Glint:**

- Samples the UV diagonally to create a simple moving mask, then adds this mask as a shine on top of the tint effect.

### 🎥 Demo / Video Link

https://github.com/user-attachments/assets/4558ff71-afb4-4c72-90b3-9481e6b17f5f


# 3. Godot Dark Mode Shader

### 📝 Description  
Dark mode is a popular visual style that makes bright elements dark and vice versa.  
In this shader challenge, I created a **2D fullscreen shader** in **Godot** that flips the brightness of every pixel on screen.  
This effect makes light colors appear dark and dark colors appear light, creating a simple but powerful “dark mode” look.

---

### 🧩 Solution  
**Key Idea:**  
- Flipping colors using `1.0 - RGB` gives you the *complementary* color, which changes the hue (e.g. blue becomes yellow).
- To preserve the hue while inverting brightness, you must switch color spaces: **convert RGB to HSV**, invert the **V (value)** channel, then convert back to RGB.
- This keeps hues consistent — so light green becomes dark green, light blue becomes dark blue, etc.

**Optimization Tip:**  
- Doing the RGB↔HSV conversion per pixel is accurate but can be expensive.
- For performance, you can pre-bake this into a **3D LUT (Lookup Table)**: RGB → HSV → invert V → HSV → RGB.  
  This reduces runtime cost to a single texture lookup instead of math on every pixel.

---

### 🎥 Demo / Video Link  

https://github.com/user-attachments/assets/ab440ee4-44ff-42a7-9503-c53faa285a67


