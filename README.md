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

