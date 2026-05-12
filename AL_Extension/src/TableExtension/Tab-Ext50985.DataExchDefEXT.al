namespace SOROUBAT_BF.SOROUBAT_BF;

using System.IO;

tableextension 50985 "Data Exch. Def EXT" extends "Data Exch. Def"
{
    fields
    {//DYS JALEL SHAIEK 0601225 New fields to define footer lines to exclude in formatted data exchange processing
        field(10000; "Etiquette Footer1"; Text[100])
        {
            Caption = 'Etiquette Footer1';
            DataClassification = ToBeClassified;
        }
        field(10001; "Colonne Footer1"; Integer)
        {
            Caption = 'Colonne Footer1';
            DataClassification = ToBeClassified;
        }
        field(10002; "Etiquette Footer2"; Text[100])
        {
            Caption = 'Etiquette Footer2';
            DataClassification = ToBeClassified;
        }
        field(10003; "Colonne Footer2"; Integer)
        {
            Caption = 'Colonne Footer2';
            DataClassification = ToBeClassified;
        }
    }
}
