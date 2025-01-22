#!/usr/bin/env python3

import os
import yaml
from jinja2 import Environment, FileSystemLoader
from pathlib import Path

class DevnetDocGenerator:
    def __init__(self, base_dir):
        self.base_dir = Path(base_dir)
        self.alphanets_dir = self.base_dir / 'alphanets'
        self.book_dir = self.base_dir / 'book'
        self.templates_dir = self.book_dir / 'gen' / 'templates'
        self.output_dir = self.book_dir / 'src'
        self.networks = {
            'alphanets': [],
            'betanets': []
        }

        # Initialize Jinja2 environment
        self.env = Environment(
            loader=FileSystemLoader(str(self.templates_dir)),
            trim_blocks=True,
            lstrip_blocks=True
        )

        # Create output directory if it doesn't exist
        self.output_dir.mkdir(parents=True, exist_ok=True)

    def load_manifest(self, manifest_path):
        """Load and parse a YAML manifest file."""
        try:
            with open(manifest_path, 'r') as f:
                return yaml.safe_load(f)
        except Exception as e:
            print(f"Error loading manifest {manifest_path}: {e}")
            return None

    def generate_markdown(self, network_data, template_name='network.md.j2'):
        """Generate markdown content from network data using the specified template."""
        try:
            template = self.env.get_template(template_name)
            return template.render(network=network_data)
        except Exception as e:
            print(f"Error generating markdown for {network_data.get('name')}: {e}")
            return None

    def write_markdown(self, content, network_name):
        """Write markdown content to the appropriate file in the output directory."""
        output_path = self.output_dir / f"{network_name}.md"
        with open(output_path, 'w') as f:
            f.write(content)
        print(f"Successfully generated documentation for {network_name}")

    def generate_summary(self):
        """Generate SUMMARY.md with links to all devnet documentation."""
        template = self.env.get_template('SUMMARY.md.j2')
        self.networks['alphanets'].sort(key=lambda x: x['name'])
        self.networks['betanets'].sort(key=lambda x: x['name'])
        content = template.render(networks=self.networks)
        summary_path = self.output_dir / 'SUMMARY.md'
        with open(summary_path, 'w') as f:
            f.write(content)
        print("Successfully generated SUMMARY.md")

    def process_devnets(self):
        """Process all devnet manifests and generate corresponding markdown files."""
        # Find all alphanet directories
        for devnet_dir in self.alphanets_dir.iterdir():
            if not devnet_dir.is_dir():
                continue

            manifest_path = devnet_dir / 'manifest.yaml'
            if not manifest_path.exists():
                print(f"No manifest.yaml found in {devnet_dir}")
                continue

            # Load and process the manifest
            network_data = self.load_manifest(manifest_path)
            if not network_data:
                continue

            # Generate and write markdown
            markdown_content = self.generate_markdown(network_data)
            if markdown_content:
                self.write_markdown(markdown_content, devnet_dir.name)
                # Store network info for SUMMARY.md
                self.networks[network_data['type'] + 's'].append(network_data)

def main():
    # Determine the base directory (assuming this script is in book/gen/)
    current_dir = Path(__file__).parent
    base_dir = current_dir.parent.parent  # Go up two levels from book/gen/

    # Initialize and run the generator
    generator = DevnetDocGenerator(base_dir)
    generator.process_devnets()
    generator.generate_summary()

if __name__ == "__main__":
    main()