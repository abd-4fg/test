~/go/bin/bbscope h1 -t h1_api_token_here -u h1_username -b -o t > data

    python3 <<EOF
import tldextract

# Read tlds file
with open('tlds', 'r') as tlds_file:
    tlds = [line.strip() for line in tlds_file]

# Read data file
with open('data', 'r') as data_file:
    urls = [line.strip() for line in data_file]

# Split URLs with multiple domains from the '*' character and add them to the list
new_urls = []
for url in urls:
    if '*' in url:
        domain = url.split('*')[1]
        new_urls.append(domain)
    else:
        new_urls.append(url)

# Find matches and extract main domains
matches = set()
for url in new_urls:
    for tld in tlds:
        if url.endswith(tld) or url.endswith(f".{tld}"):
            ext = tldextract.extract(url)
            main_domain = f"{ext.domain}.{ext.suffix}"
            matches.add(main_domain)
            break

# Sort and print the matches
matches = sorted(matches)
for match in matches:
    print(match)
EOF
