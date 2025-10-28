import sys, types, logging, runpy

# Simula el módulo camel.logger
camel = types.ModuleType("camel")
logger = types.ModuleType("camel.logger")
logger.get_logger = lambda name=None: logging.getLogger(name)
sys.modules["camel"] = camel
sys.modules["camel.logger"] = logger

print("✅ Módulo camel.logger simulado permanentemente.\n")

# Ejecuta OWL normalmente
runpy.run_module("owl.webapp", run_name="__main__")
