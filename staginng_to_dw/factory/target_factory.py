from factory import objectfactory_with_parms
from processor import targetprocessor as tp


class TargetFactory(objectfactory_with_parms.ObjectFactory):
    def get(self, target_type, **kwargs):
        return self.create(target_type, **kwargs)


target_factory = TargetFactory()
target_factory.register_builder("postgresql", tp.Postgresql())
