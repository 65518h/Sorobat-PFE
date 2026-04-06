TableExtension 50037 "Sales Shipment HeaderEXT" extends "Sales Shipment Header"
{
    fields
    {
        /* GL2024
modify("No. Printed")
{
     Editable=true;
}*/


        field(50000; "Critére Eval Fournisseur"; Option)
        {
            OptionCaption = 'Prix,Delai,Note';
            OptionMembers = Prix,Delai,Note;
        }
        field(50001; "Requester ID"; Text[30])
        {
            Caption = 'ID Demandeur';
            Description = '// DDE D''APPRO';
            Editable = true;
            TableRelation = Demandeur."Nom Et Prenom";
        }
        field(50002; Service; Option)
        {
            Description = '// DDE D''APPRO';
            OptionMembers = " ","Parc Z4","Direction Gen","Dir Audit","Dir Cpt Et Admin","Dir Financiere","Controle Et Gestion",Appro,Secreteriat,BaseVie;
        }
        field(50003; "Type Demande"; Option)
        {
            Description = '// DDE D''APPRO';
            OptionCaption = 'Pièce de Rechange,Materiaux,Fourniture et Divers,Prestation de Service';
            OptionMembers = "Pièce de Rechange",Materiaux,"Fourniture et Divers","Prestation de Service";
        }
        field(50004; Synchronise; Boolean)
        {
        }
        field(50007; Observation; Text[50])
        {
        }
        field(50006; "Apply Stamp fiscal"; Boolean)
        {
            Caption = 'Stamp Fiscal';
            Description = 'STD V1.0';
            InitValue = false;
        }
        field(50015; Approbateur; Code[10])
        {
            Description = '// DDE D''APPRO';
        }
        field(50016; "Date appropation"; Date)
        {
            Description = '// DDE D''APPRO';
        }
        field(50017; Statut; Option)
        {
            Caption = 'Approval';
            Description = '// DDE D''APPRO';
            OptionCaption = 'Pending,accepted,refused';
            OptionMembers = Ouvert,"Lancé","Partiellement Pris En Charge","Totallement Pris En Charge",Archiver;

            trigger OnValidate()
            var
                RecPurchaseSetup: Record "Purchases & Payables Setup";
                RecItem: Record Item;
                RecSalesLine: Record "Sales Line";
            begin
            end;
        }
        field(50018; Approber; Boolean)
        {
            Description = '// DDE D''APPRO';

            trigger OnValidate()
            var
                RecSalesLine: Record "Sales Line";
                Text0002: label 'Code Magasin Doit Etre Renseigner Pour Article %1';
            begin
            end;
        }
        field(50019; Engin; Code[20])
        {
            Description = 'HJ DSFT 15-02-2013';
            TableRelation = Véhicule;
        }
        field(50020; Type; Code[20])
        {
            Description = 'HJ DSFT 15-02-2013';
        }
        field(50021; "N° Serie"; Code[20])
        {
            Description = 'HJ DSFT 15-02-2013';
        }
        field(50022; "Description Engin"; Text[50])
        {
            Description = 'HJ DSFT 15-02-2013';
            Editable = false;
        }
        field(50023; "Receptionné"; Boolean)
        {
            Description = 'HJ SORO 16-10-2014';
        }
        field(50024; "Commande Achat Associé"; Code[20])
        {
            CalcFormula = lookup("Purchase Header"."No." where("N° Demande d'achat" = field("No."),
                                                                "Document Type" = const(Order)));
            Description = 'HJ SORO 23-02-2015';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60007; "DA Approbé"; Boolean)
        {
            Description = 'RB SORO 21/04/2015';
        }
        field(60008; "Approbateur DA"; Code[20])
        {
            Description = 'RB SORO 21/04/2015';
        }
        field(50027; "Commande Interne"; Boolean)
        {
            Description = 'HJ SORO 01-07-2015';
        }
        field(50028; Marche; Boolean)
        {
            Description = 'HJ SORO 11-10-2016';
        }
        field(50025; "Jours Retard"; Integer)
        {
            Description = 'HJ SORO 09-08-2016';
        }
        field(50030; "Commande Affaire"; Boolean)
        {
            Description = 'HJ SORO 18-09-2013';
        }
        field(50031; "Type Commande"; Option)
        {
            Description = 'HJ SORO 16-02-2016';
            OptionMembers = " ",Beton,Carriere;
        }
        field(50041; Heure; Time)
        {
            Description = 'MH SORO 18-03-2021';
        }
        field(50044; Destination; Text[30])
        {
            Description = 'MH SORO 18-03-2021';
        }
        field(50045; "Pompage Béton"; Boolean)
        {
            Description = 'MH SORO 18-03-2021';
        }
        field(50046; "Matricule Pompe"; Code[10])
        {
            Description = 'MH SORO 18-03-2021';
        }
        field(60001; "Alerte Imminente"; Boolean)
        {
            Description = 'HJ SORO 08-11-2016';
        }
        field(60002; "Alerte Imminente Desactivé"; Boolean)
        {
            Description = 'HJ SORO 08-11-2016';
        }
        field(60003; "Alerte Imminente Declanché"; Boolean)
        {
            Description = 'HJ SORO 08-11-2016';
        }
        field(60004; "Date Debut Decompte"; Date)
        {
            Description = 'HJ SORO 22-06-2017';
        }
        field(60005; "Date Fin Decompte"; Date)
        {
            Description = 'HJ SORO 22-06-2017';
        }
        field(60006; "Total Decompte"; Decimal)
        {
            CalcFormula = sum("Sales Shipment Line".Montant where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(82750; "Mask Code"; Code[10])
        {
            Caption = 'Mask Code';
            TableRelation = Mask;
        }
        field(8003923; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            Description = 'TestTableRelation=No';
            TableRelation = Job;
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(82751; Avancement; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(82752; "Montant Cumulé"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {

        /*GL2024    key(STG_Key8;"Job No.","Posting Date")
            {
            }*/
    }



}

