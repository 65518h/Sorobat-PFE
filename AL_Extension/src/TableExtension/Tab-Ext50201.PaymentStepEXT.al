TableExtension 50201 "Payment StepEXT" extends "Payment Step"
{
    fields
    {

        field(50010; "Compta. montant initial"; Boolean)
        {
            Description = 'AGA DSFT  09/06/2011';
        }
        field(50601; Agence; Code[10])
        {
            Description = 'MER';
            TableRelation = Agence;
        }
        field(50602; "Code Origine Obligatoire"; Boolean)
        {
            Description = 'MBK';
        }
        field(50603; "Statut Facture"; Option)
        {
            OptionMembers = ,"Vérifié ET Comptabilisé","En Cours De Paiement","En Cours De Signature",Signée,Payée,"Payée Et Archivé";
        }
        field(50611; "Libelle Type Reglement text"; Text[50])
        {
            CalcFormula = lookup("Payment Class".Name where(Code = field("Payment Class")));
            FieldClass = FlowField;
        }
    }



}

