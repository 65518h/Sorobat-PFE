Table 50015 "Ligne Dossiers d'Importation"
{
    DrillDownPageID = "Lignes Dossiers d'Importation";
    LookupPageID = "Lignes Dossiers d'Importation";
    PasteIsValid = false;

    fields
    {
        field(1; "N° dossier"; Code[20])
        {
            Editable = true;
            TableRelation = "Dossiers d'Importation";
        }
        field(2; "N° ligne"; Integer)
        {
            Editable = false;
        }
        field(3; "N° preneur d'ordre"; Code[20])
        {
            Editable = false;
            TableRelation = Vendor;
        }
        field(4; "N° réception"; Code[20])
        {
            Editable = false;
            TableRelation = "Purch. Rcpt. Header"."No." where("No." = field("N° réception"));
        }
        field(5; "N° ligne réception"; Integer)
        {
            Editable = false;
            TableRelation = "Purch. Rcpt. Line"."Line No." where("Document No." = field("N° réception"));
        }
        field(6; "N° article"; Code[20])
        {
            Editable = false;
            TableRelation = Item;
        }
        field(7; "Code magasin"; Code[10])
        {
            Editable = false;
            TableRelation = Location;
        }
        field(8; "Désignation"; Text[80])
        {
            Editable = false;
        }
        field(9; "Désignation 2"; Text[80])
        {
            Editable = false;
        }
        field(10; "Quantité"; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                //*NSC1.10
                if Quantité <> xRec.Quantité then begin
                    if Quantité > xRec.Quantité then
                        Error('La nouvelle quantité doit être inférieure à l''ancienne')
                    else
                        "Quantité (base)" := Quantité * "Quantité par unité";
                    CU := xRec.Montant / xRec."Quantité (base)";
                    CUDevSoc := xRec."Montant (dev soc)" / xRec."Quantité (base)";
                    Montant := CU * "Quantité (base)";
                    "Montant (dev soc)" := CUDevSoc * "Quantité (base)";
                    Validate(Volume);
                    Modify;
                    Commit;
                    //  MAJStock(Rec,xRec,1);
                end;
                //*FIN :NSC1.10
            end;
        }
        field(11; "Coût unitaire direct"; Decimal)
        {
            AutoFormatExpression = "Code devise";
            AutoFormatType = 2;
            Editable = true;
        }
        field(12; "Coût unitaire (dev soc)"; Decimal)
        {
            AutoFormatType = 2;
            Editable = true;
        }
        field(13; Montant; Decimal)
        {
            AutoFormatType = 1;
            Editable = true;
        }
        field(14; "Prix unitaire (dev soc)"; Decimal)
        {
            AutoFormatType = 2;
            Editable = true;
        }
        field(15; "Référence fournisseur"; Text[20])
        {
            Editable = false;
        }
        field(17; "Coût unitaire"; Decimal)
        {
            AutoFormatType = 2;
            Editable = true;
        }
        field(18; "Conditionnement produit"; Code[10])
        {
            Editable = true;

            trigger OnValidate()
            begin
                //*NSC1.10
            end;
        }
        field(19; "Quantité (base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(20; "Coût unitaire direct (base)"; Decimal)
        {
            AutoFormatExpression = "Code devise";
            AutoFormatType = 2;

            trigger OnValidate()
            begin
                //* PN 24/12/99 NSC1.67 3973

                DossArr.Get("N° dossier");
                //MBY 13/01/2012
                //IF DossArr.Statut = DossArr.Statut::Clôturé THEN
                //  ERROR('Toute modification est interdite si le dossier d''arrivage est clôturé. Taper Echapp. pour annuler la saisie');

                //IF "Coût unitaire direct (base)" = xRec."Coût unitaire direct (base)" THEN
                //EXIT;
                //MBY 13/01/2012
                //* mise à jour des autres montants et des autre coûts
                "Coût unitaire direct" := "Coût unitaire direct (base)";
                "Coût unitaire" := "Coût unitaire direct (base)" * "Quantité par unité";
                Montant := "Coût unitaire direct (base)" * "Quantité (base)";
                if "Facteur devise" <> 0 then begin
                    "Montant (dev soc)" := Montant / "Facteur devise";
                    "Coût unitaire (dev soc)" := "Coût unitaire direct (base)" / "Facteur devise";
                    "Prix unitaire (dev soc)" := "Coût unitaire direct (base)" / "Facteur devise";
                end else begin
                    "Montant (dev soc)" := Montant;
                    "Coût unitaire (dev soc)" := "Coût unitaire direct (base)";
                    "Prix unitaire (dev soc)" := "Coût unitaire direct (base)";
                end;

                //* PN 24/12/99 NSC1.63 3957
                "Montant modifié" := true;
                Modify;
                /*
                //MBY 13/01/2012
                IF Articles.GET("N° article") THEN
                  BEGIN
                    Articles."N° Dossier (PRR)" := "N° dossier";
                    Articles."Date dossier (PRR)" := WORKDATE;
                    Articles."Dernier PA en Devise" := "Coût unitaire (dev soc)";
                    Articles.DPRR :="Coût unitaire (dev soc)";
                    Articles.MODIFY;
                  END
                //MBY 13/01/2012
                  */
                /*
                //* signale qu'il y a des prestations associés
                PrestLigDoss.SETRANGE("N° dossier", "N° dossier");
                //* PN 1.72 31/12/99
                PrestLigDoss.SETRANGE("N° ligne dossier", "N° ligne");
                //* FIN PN 1.72 31/12/99
                NumerosPrest := '';
                IF PrestLigDoss.FIND('-') THEN BEGIN
                  REPEAT
                    PrestLigDoss."Montant ligne (dev soc)" := "Montant (dev soc)";
                    PrestLigDoss.MODIFY;
                    NumerosPrest := NumerosPrest + ' ' + PrestLigDoss."N° prestation";
                  UNTIL PrestLigDoss.NEXT = 0;
                
                  IF NumerosPrest <> '' THEN
                    MESSAGE('La modification du coût unitaire a un impact sur le montant total du dossier. Or le '
                            + 'montant total est susceptible d''avoir été utilisé pour calculer l''affectation '
                            + 'de prestation(s) (%1) à ce dossier. Vérifiez s''il faut recalculer cette ou ces '
                            + 'affectations (Prestation/Dossier d''arrivage/Fonctions/Calculer les montants par dossier',NumerosPrest);
                END;
                //* FIN PN 24/12/99 NSC1.63 3957
                                 */

            end;
        }
        field(21; "Montant (dev soc)"; Decimal)
        {
            AutoFormatType = 1;
            Description = 'Montant * facteur devise (si <> 0)';
            Editable = true;
        }
        field(22; Volume; Decimal)
        {
            Description = 'Soit volume PCB * Qté, si pas de PCB Volume article * Qté (pièce)';
            Editable = false;

            trigger OnValidate()
            begin
                //*NSC1.10
                Articles.Get("N° article");
                Volume := Articles."Unit Volume" * "Quantité (base)";
                //*FIN :NSC1.10
            end;
        }
        field(23; "% remise ligne"; Decimal)
        {
            Editable = true;
            MaxValue = 100;
            MinValue = 0;
        }
        field(24; "N° commande"; Code[20])
        {
            Editable = false;
        }
        field(25; "Quantité par unité"; Decimal)
        {
            Editable = false;
        }
        field(26; "Code devise"; Code[10])
        {
            Editable = false;
            TableRelation = Currency;
        }
        field(27; "Facteur devise"; Decimal)
        {
            DecimalPlaces = 1 : 15;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                if "Facteur devise" <> 0 then begin
                    "Montant (dev soc)" := Montant / "Facteur devise";
                    "Prix unitaire (dev soc)" := "Coût unitaire direct" / "Facteur devise";
                    "Coût unitaire (dev soc)" := "Coût unitaire direct" / "Facteur devise";
                end else begin
                    "Montant (dev soc)" := Montant;
                    "Prix unitaire (dev soc)" := "Coût unitaire direct";
                    "Coût unitaire (dev soc)" := "Coût unitaire direct";
                end;
            end;
        }
        field(28; "N° ligne commande"; Integer)
        {
            Editable = false;
        }
        field(29; "Montant modifié"; Boolean)
        {
            Editable = false;
        }
        field(30; "Devise modifiée"; Boolean)
        {
            Editable = false;
        }
        field(40; "Date Déclaration"; Date)
        {
        }
    }

    keys
    {
        key(STG_Key1; "N° dossier", "N° ligne", "N° réception", "N° article")
        {
            Clustered = true;
            SumIndexFields = Montant, Volume, "Montant (dev soc)", "Quantité", "Quantité (base)";
        }
        key(STG_Key2; "N° commande", "N° ligne commande")
        {
        }
        key(STG_Key3; "N° dossier", "N° article", "N° réception", "N° ligne réception")
        {
        }
        key(STG_Key4; "N° article", "Date Déclaration", "N° dossier")
        {
        }
        key(STG_Key5; "N° réception", "N° ligne réception", "N° article", "N° dossier")
        {
        }
        key(STG_Key6; "N° article")
        {
            SumIndexFields = Montant, Volume, "Montant (dev soc)", "Quantité", "Quantité (base)";
        }
    }

    fieldgroups
    {
    }

    var
        DossArr: Record "Dossiers d'Importation";
        Articles: Record Item;
        NLigne: Integer;
        CU: Decimal;
        CUDevSoc: Decimal;
        "ModèleFA": Record "Item Journal Template";
        CodeJournal: Code[10];
        GestionNoSouche: Codeunit 396;
        NumerosPrest: Text[30];
}

