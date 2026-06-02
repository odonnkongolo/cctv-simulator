from PIL import Image

def get_bg(img_path):
    img = Image.open(img_path)
    return img.getpixel((10, 10))

print("Image 1 bg:", get_bg("/Users/ojayodon/.gemini/antigravity-ide/brain/19276a80-db4c-421b-a0ad-63ada1ddaafb/pasted_image_0.png"))
print("Image 2 bg:", get_bg("/Users/ojayodon/.gemini/antigravity-ide/brain/19276a80-db4c-421b-a0ad-63ada1ddaafb/pasted_image_1.png"))
