from importlib.metadata import distribution


def test_installed_distribution_exposes_SynapseAI_extension_entry_point() -> None:
    entry_points = [entry_point for entry_point in distribution("SynapseAI-extension-example").entry_points if entry_point.group == "SynapseAI.extensions"]

    assert [(entry_point.name, entry_point.value) for entry_point in entry_points] == [("example", "SynapseAI_extension_example:install")]

    install = entry_points[0].load()
    assert install.__SynapseAI_api__ == "0.1.2"
    assert install.__SynapseAI_name__ == "example"
