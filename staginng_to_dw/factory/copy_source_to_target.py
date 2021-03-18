from transformationprocessor import TransformationProcessor
import pandas as pd


class CopySourceToTarget(TransformationProcessor):
    def load_to_target_dataframe(self):
        for (columnName, columnData) in self.source_df.iteritems():
            target_df = self.source_df
        return target_df
