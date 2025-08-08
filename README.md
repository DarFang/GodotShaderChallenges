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


# 4. Godot Fish-Eye Distortion Shader

### 📝 Description  
Lots of different games that want to simulate a **video camera lens** or the view from a **robot’s perspective** use a fish-eye effect to make the screen feel distorted and immersive.  
In this challenge, I tackled that exact problem by building a **2D shader** in **Godot** that warps the screen outward using a fish-eye distortion.  
The result is a curved lens feel that can be used for robot UIs, retro cameras, or just to add visual flair to a scene.

### 🧩 Solution  
**Fish-Eye Distortion:**  
- We compute the **offset from the center** of the screen to each pixel.  
- Then we use the **squared distance** (dot product instead of expensive length()) to control the **distortion strength**.  
- Finally, we remap the UV by adding the offset times the distortion amount back to the center.  
- This shifts pixels outward, giving the warped fish-eye look.

> The fish-eye effect works best when the source image or texture **doesn't have important visual details near the corners**, since those areas may get heavily stretched or clipped.  
> To improve the effect, it’s recommended to **zoom in slightly** or render a **larger area into a `ViewportTexture`** so the distortion has enough pixel data to pull from.

### 🎥 Demo / Video Link  
![ShdaerChallenge4](https://github.com/user-attachments/assets/61b88e02-7287-4409-8ed8-9b3a95a482eb)

# 5. Godot Pixelation Shader

### 📝 Description  
Pixelation is a versatile visual effect commonly used in games for stylistic transitions, blurring sensitive images, or creating retro aesthetics.  
In this shader challenge, I developed a **2D shader** in **Godot** that pixelates the screen, similar to the iconic encounter transition seen in classic Pokémon battles.  
This effect reduces visual clarity, creating a blocky, nostalgic look.

---

### 🧩 Solution  
**Pixelation Technique:**  
- Calculate the **pixel resolution** based on the screen’s aspect ratio and a user-defined scaling factor.  
- Multiply the original UV coordinates by this pixel resolution.  
- Use the `floor()` function to snap to the nearest lower coordinate.  
- Divide by the pixel resolution to return to normalized UV space.  
- Sample the texture at these modified coordinates and replace the pixel color.  

This groups pixels together into larger blocks, resulting in the pixelated effect.

---

### 🎥 Demo / Video Link  
![ShaderChallenge5](https://github.com/user-attachments/assets/68468bd4-83ec-4069-baa8-cb638dd339cb)

# 6. Godot ASCII Shader

### 📝 Description  
Following up on last week’s **Pixelation Shader**, I wanted to push the retro aesthetic further by replacing each pixel block with an **ASCII character**.  
This effect maps image brightness to text glyphs, creating that classic “ASCII art” look,  but in real-time inside Godot.  

It’s a fun way to turn a scene into something that feels printed on an old terminal screen.  

---

### 🧩 Solution  

**Pixelation Base (from Challenge #5):**  
- Start with the same **pixelation grid resolution** to break the screen into larger blocks.  

**Brightness to ASCII Index:**  
- For each pixel block, grab its **illuminance value** (brightness).  
- Map this value to an **ASCII index**, choosing characters from a pre-made ASCII texture (PNG).  

**Character Sampling:**  
- Use the **fractional part** of the UV (multiplied by the grid resolution) to locate the correct character in the ASCII texture.  
- Sample the pixel from the ASCII character grid and overlay it onto the scene.  

**Possible Improvements:**  
- Sample from the **center of each block** instead of the corner for more accurate glyph selection.  
- Take the **average brightness** of the block to better represent detailed images.  
- Experiment with RGB → HSV conversion to **boost lightness or saturation**, although high saturation can make faces and subtle details look unnatural.  

---

### 🎥 Demo / Video Link  
![challenge-6](https://github.com/user-attachments/assets/ac737e90-c500-423c-a707-bd5e30ae83b6)

