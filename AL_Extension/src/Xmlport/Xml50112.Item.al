xmlport 50112 "Item Last Price"
{ //GL2024  ID dans Nav 2009 : "39001405"
    Direction = Import;
    Format = VariableText;
    Caption = 'Dernier Prix';
    UseRequestPage = false;
    TableSeparator = '<NewLine><NewLine>';
    FieldSeparator = ';';

    schema
    {
        textelement(Root)
        {
            tableelement(EtatMensuellePaie; item)   // Table 39001439
            {
                AutoSave = false;
                AutoUpdate = false;




                fieldelement(No; EtatMensuellePaie."No.")
                {
                }
                fieldelement(Description; EtatMensuellePaie.Description)
                {
                }
                fieldelement(Dernierdateachat; EtatMensuellePaie."Dernier date achat")
                {
                }
                fieldelement(DernierPrixachat; EtatMensuellePaie."Dernier Prix achat")
                {
                }
            }

        }
    }

    var
    // MatTxt: Code[10];
    // Heure15Txt: Decimal;
    // Heure35Txt: Decimal;
    // Heure50Txt: Decimal;
    // Heure60Txt: Decimal;
    // Heure120Txt: Decimal;
    // HeureNormaleTxt: Decimal;
}
