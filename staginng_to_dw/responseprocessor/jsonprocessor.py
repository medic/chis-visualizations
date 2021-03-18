from responseprocessor.iresponseprocessor import ResponseProcessor as  Processor
import pandas as pd
from io import StringIO
import json

class JsonSimpleProcessor(Processor):
    def load_to_dataframe(self):
        first_tuple_elements = []
        for entry in self.data:
            first_tuple_elements.append(entry[0])
        df = pd.DataFrame.from_dict(first_tuple_elements)
        return df

class JsonNormalizeProcessor:
    def load_to_dataframe(self):
        return pd.json_normalize(self.data)


class ListAsJsonProcessor:
    def load_to_dataframe(self):
        json_response = json.loads(self.data.content.decode('utf-8'))
        return pd.DataFrame(json_response)


class ScalarValuesAsJson:
    def load_to_dataframe(self):
        return pd.DataFrame(self.data, index=[0])
