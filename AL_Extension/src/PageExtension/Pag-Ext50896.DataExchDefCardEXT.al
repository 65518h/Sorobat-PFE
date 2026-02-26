namespace SOROUBAT_BF.SOROUBAT_BF;

using System.IO;

pageextension 50896 "Data Exch Def Card EXT" extends "Data Exch Def Card"
{
    // DYS JALEL SHAIEK  Layout Extension to show new fields in Data Exch Def Card Page
    layout
    {
        addafter("Footer Tag")
        {
            field("Etiquette Footer1"; Rec."Etiquette Footer1")
            {
                ApplicationArea = All;
            }
            field("Clonne Footer1"; Rec."Colonne Footer1")
            {
                ApplicationArea = All;
            }
            field("Etiquette Footer2"; Rec."Etiquette Footer2")
            {
                ApplicationArea = All;
            }
            // field("Clonne Footer2"; Rec."Clonne Footer2")
            // {
            //     ApplicationArea = All;
            // }
        }
    }
}
