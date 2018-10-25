import pandas as pd
import numpy as np
df=pd.read_csv("A:/dv/lab/lab12/BirdStikes.csv")
def get_parts(row):
    if row['Effect: Indicated Damage']=="Caused damage":
        if pd.notnull(row['Remarks']):
            if "LANDING GEAR" in row['Remarks']:
                row['damaged part']="Landing gear"
            elif "NOSE" in row['Remarks']:
                row['damaged part']="Nose"
            elif "WINDOW" in row['Remarks']:
                row['damaged part']="Window"
            elif "WINDSHIELD" in row['Remarks']:
                row['damaged part']="Windshield"
            else:
                row['damaged part']="Other"
        else:
            row['damaged part']="unknown"
            row['damage_t']="unknown"
    else:
        row['damaged part']='No damage'
    if pd.notnull(row['Remarks']):
        if "SUBSTANTIAL" in row['Remarks']:
            row['damage_t']="substantial"
        elif "NO DMG" in row['Remarks']:
            row['damage_t']="No damage"
        elif "DMG" in row['Remarks']:
            row['damage_t']="moderate"
    else:
        row['damage_t']="unknown"
    return row
df=df.apply(get_parts,axis=1)
df.to_csv("A:/dv/lab/lab12/BirdStikes.csv")
