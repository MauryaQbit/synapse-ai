import os

replacements = {
    'SynapseAI': 'SynapseAI',
    'synapse': 'synapse',
    'synapse-ai': 'synapse-ai',
    'MauryaQbit/synapse-ai': 'MauryaQbit/synapse-ai',
    'synapse.tech': 'synapseai.dev',
    'support@synapse.tech': 'support@synapseai.dev',
    'SYNAPSE': 'SYNAPSE',
}

skip_dirs = {'node_modules', '.next', '__pycache__', '.git', '.synapse-ai', '.synapse', 'venv', '.venv'}
skip_exts = {'.pyc', '.pyo', '.lock', '.sum'}

count = 0
for root, dirs, files in os.walk('.'):
    dirs[:] = [d for d in dirs if d not in skip_dirs]
    for f in files:
        if any(f.endswith(ext) for ext in skip_exts):
            continue
        path = os.path.join(root, f)
        try:
            with open(path, 'r', encoding='utf-8', errors='ignore') as fh:
                content = fh.read()
            new_content = content
            for old, new in replacements.items():
                new_content = new_content.replace(old, new)
            if new_content != content:
                with open(path, 'w', encoding='utf-8') as fh:
                    fh.write(new_content)
                count += 1
                print(f'Updated: {path}')
        except Exception as e:
            pass
print(f'\nTotal files updated: {count}')
