import os

def analyze_file(filepath):
    with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()
        lines = content.splitlines()
        words = content.split()
        vowels = sum(1 for char in content.lower() if char in 'aeiou')
        return len(lines), len(words), vowels

def analyze_repo(root='.'):
    total_lines = total_words = total_vowels = 0

    for subdir, _, files in os.walk(root):
        for file in files:
            if file.endswith('.py'):  # Change this to include other file types if needed
                path = os.path.join(subdir, file)
                lines, words, vowels = analyze_file(path)
                total_lines += lines
                total_words += words
                total_vowels += vowels

    print(f"Total Lines: {total_lines}")
    print(f"Total Words: {total_words}")
    print(f"Total Vowels: {total_vowels}")

if __name__ == '__main__':
    analyze_repo()
