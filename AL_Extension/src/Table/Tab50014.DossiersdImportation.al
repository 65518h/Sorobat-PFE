Table 50014 "Dossiers d'Importation"
{
    DrillDownPageID = "Liste Dossiers d'Importation";
    LookupPageID = "Liste Dossiers d'Importation";
    Permissions = TableData "Purch. Inv. Header" = rm,
                  TableData "Purch. Inv. Line" = rm,
                  TableData "Value Entry" = rm;

    fields
    {
        field(1; "N° Dossier"; Code[20])
        {
            Editable = true;
        }
        field(3; "Date d'ouverture"; Date)
        {
            Editable = false;
        }
        field(4; "Date de clôture"; Date)
        {
            Editable = false;
        }
        field(5; "N° Fournisseur"; Code[20])
        {
            Editable = true;
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                //*** HK DSFT
                if Frs.Get("N° Fournisseur") then
                    "Nom fournisseur" := Frs.Name;
                //*** HK DSFT
            end;
        }
        field(6; "Souches de N°"; Code[20])
        {
            Editable = false;
            //GL2024    TableRelation = Table0;
        }
        field(8; "Frais Financiers"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Value Entry"."Cost Amount (Actual)" where("N° Dossier" = field("N° Dossier"),
                                                                          "Invoiced Quantity" = filter(0),
                                                                          "Valued Quantity" = filter(<> 0),
                                                                          "Type Frais" = filter("Frais Financiers")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; Assurances; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Value Entry"."Cost Amount (Actual)" where("N° Dossier" = field("N° Dossier"),
                                                                            "Invoiced Quantity" = filter(0),
                                                                            "Valued Quantity" = filter(<> 0),
                                                                            "Type Frais" = filter(Assurances)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; Magasinage; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Value Entry"."Cost Amount (Actual)" where("N° Dossier" = field("N° Dossier"),
                                                                          "Invoiced Quantity" = filter(0),
                                                                          "Valued Quantity" = filter(<> 0),
                                                                          "Type Frais" = filter(Magasinage)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; Transit; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Value Entry"."Cost Amount (Actual)" where("N° Dossier" = field("N° Dossier"),
                                                                          "Invoiced Quantity" = filter(0),
                                                                          "Valued Quantity" = filter(<> 0),
                                                                          "Type Frais" = filter(Transit)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; Douane; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Value Entry"."Cost Amount (Actual)" where("N° Dossier" = field("N° Dossier"),
                                                                          "Invoiced Quantity" = filter(0),
                                                                          "Valued Quantity" = filter(<> 0),
                                                                          "Type Frais" = filter(Douane)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Nom fournisseur"; Text[60])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("N° Fournisseur")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; Statut; Option)
        {
            Editable = true;
            OptionMembers = " ","En attente de facturation","Facturé","Clôturé";

            trigger OnValidate()
            var
                Br: Record "Purch. Rcpt. Header";
                LigTmp: Record "Ligne Dossiers d'Importation";
            begin
                if xRec.Statut <> Statut then begin
                    // Si on clôture le dossier
                    if Statut = Statut::Clôturé then
                        if not Confirm('Voulez-vous clôturer ce dossier d''arrivage ?') then begin
                            Error('Changement d''état annulé');
                        end else begin
                            CalcFields("Frais Financiers en instance", "Assurances en Instance", "Magasinage en Instance", "Transit en instance",
                                 "Douane en Instance", "F. d'emb./ mise à FOB en inst.", "Frêt en instance", "Frais D'acconage en Instance",
                                 "Dif. Change en Instance", "Transport en Instance", "Frais Bancaires en Instance", "Etat et taxes en Instance",
                                 "Autres Frais en Instance");
                            if ("Frais Financiers en instance" + "Assurances en Instance" + "Magasinage en Instance" + "Transit en instance" +
                            "Douane en Instance" + "F. d'emb./ mise à FOB en inst." + "Frêt en instance" + "Frais D'acconage en Instance" +
                            "Dif. Change en Instance" + "Transport en Instance" + "Frais Bancaires en Instance" + "Etat et taxes en Instance" +
                            "Autres Frais en Instance") <> 0 then
                                Error('Vous devez Valider Les Factures Des Frais de ce Dossier !!!');

                            RecalculerCoût;
                            //CalculerPR.CalculerPRRViaDossier(Rec,TRUE);
                            //REPORT.RUN(50062,FALSE,FALSE,Rec);
                            "Date de clôture" := WorkDate;
                            Statut := 0;
                            LigTmp.Reset;
                            LigTmp.SetFilter("N° dossier", "N° Dossier");
                            LigTmp.ModifyAll("Date Déclaration", "Date Déclaration");
                            Statut := Statut::Clôturé;
                            Modify;
                            ActualiserLignesFactures;
                        end;

                    // Si on ré-ouvre le dossier
                    if xRec.Statut = Statut::Clôturé then
                        if not Confirm('Attention : ce dossier d''arrivage est clôturé. Voulez-vous changer son état ?') then begin
                            Error('Changement d''état annulé');
                        end else begin
                            //* NSC1.22 PN 4/11/99
                            FactureAchat.SetRange("N° Dossier", "N° Dossier");
                            //IF FactureAchat.FIND('-') THEN
                            //ERROR(STRSUBSTNO('Le dossier %1 a été facturé (facture N° %2). '+
                            //                 'L''état ne peut plus être changé',"N° dossier",FactureAchat."No."));
                            //* FIN NSC1.22 PN 4/11/99
                            AnnActualiserLignesFactures;

                            Modify;
                        end;
                end;
            end;
        }
        field(15; "Mnt Total Lig Doss (dev soc)"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Ligne Dossiers d'Importation"."Montant (dev soc)" where("N° dossier" = field("N° Dossier")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; Volume; Decimal)
        {
        }
        field(17; "Code condition livraison"; Code[20])
        {
            Editable = false;
            //GL2024   TableRelation = Table0;
        }
        field(18; "Frais d'emballage / mise à FOB"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Value Entry"."Cost Amount (Actual)" where("N° Dossier" = field("N° Dossier"),
                                                                          "Invoiced Quantity" = filter(0),
                                                                          "Valued Quantity" = filter(<> 0),
                                                                          "Type Frais" = filter("Frais d'emballage / mise à FOB"),
                                                                          "Source Type" = filter(Vendor),
                                                                          "Source No." = field("Filter Fournisseur")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Frêt"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Value Entry"."Cost Amount (Actual)" where("N° Dossier" = field("N° Dossier"),
                                                                          "Invoiced Quantity" = filter(0),
                                                                          "Valued Quantity" = filter(<> 0),
                                                                          "Type Frais" = filter(Frèt),
                                                                          "Source Type" = filter(Vendor),
                                                                          "Source No." = field("Filter Fournisseur")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Frais D'acconage"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Value Entry"."Cost Amount (Actual)" where("N° Dossier" = field("N° Dossier"),
                                                                          "Invoiced Quantity" = filter(0),
                                                                          "Valued Quantity" = filter(<> 0),
                                                                          "Type Frais" = filter("Frais D'acconage"),
                                                                          "Source Type" = filter(Vendor),
                                                                          "Source No." = field("Filter Fournisseur")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "Montant (dev Soc)"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Ligne Dossiers d'Importation"."Montant (dev soc)" where("N° dossier" = field("N° Dossier")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "Dif. Change"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Value Entry"."Cost Amount (Actual)" where("N° Dossier" = field("N° Dossier"),
                                                                          "Invoiced Quantity" = filter(0),
                                                                          "Valued Quantity" = filter(<> 0),
                                                                          "Type Frais" = filter("Dif. Change"),
                                                                          "Source Type" = filter(Vendor),
                                                                          "Source No." = field("Filter Fournisseur")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; Transport; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Value Entry"."Cost Amount (Actual)" where("N° Dossier" = field("N° Dossier"),
                                                                          "Invoiced Quantity" = filter(0),
                                                                          "Valued Quantity" = filter(<> 0),
                                                                          "Type Frais" = filter(Transport),
                                                                          "Source Type" = filter(Vendor),
                                                                          "Source No." = field("Filter Fournisseur")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Frais Bancaires"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Value Entry"."Cost Amount (Actual)" where("N° Dossier" = field("N° Dossier"),
                                                                          "Invoiced Quantity" = filter(0),
                                                                          "Valued Quantity" = filter(<> 0),
                                                                          "Type Frais" = filter("Frais Bancaires"),
                                                                          "Source Type" = filter(Vendor),
                                                                          "Source No." = field("Filter Fournisseur")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; "Etat et taxes"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Value Entry"."Cost Amount (Actual)" where("N° Dossier" = field("N° Dossier"),
                                                                          "Invoiced Quantity" = filter(0),
                                                                          "Valued Quantity" = filter(<> 0),
                                                                          "Type Frais" = filter("Etat et taxes"),
                                                                          "Source Type" = filter(Vendor),
                                                                          "Source No." = field("Filter Fournisseur")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(26; "Autres Frais"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Value Entry"."Cost Amount (Actual)" where("N° Dossier" = field("N° Dossier"),
                                                                          "Invoiced Quantity" = filter(0),
                                                                          "Valued Quantity" = filter(<> 0),
                                                                          "Type Frais" = filter("Autres Frais"),
                                                                          "Source Type" = filter(Vendor),
                                                                          "Source No." = field("Filter Fournisseur")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; "Frais Débarquement"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Value Entry"."Cost Amount (Actual)" where("N° Dossier" = field("N° Dossier"),
                                                                          "Invoiced Quantity" = filter(0),
                                                                          "Valued Quantity" = filter(<> 0),
                                                                           //GL2024 "Type Frais" = filter(14),
                                                                           "Type Frais" = filter("Autres Frais"),
                                                                          "Source Type" = filter(Vendor),
                                                                          "Source No." = field("Filter Fournisseur")));
            Description = 'Houcine';
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; "Frais Portuaire"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Value Entry"."Cost Amount (Actual)" where("N° Dossier" = field("N° Dossier"),
                                                                          "Invoiced Quantity" = filter(0),
                                                                          "Valued Quantity" = filter(<> 0),
                                                                          //GL2024  "Type Frais" = filter(14),
                                                                          "Type Frais" = filter("Autres Frais"),
                                                                          "Source Type" = filter(Vendor),
                                                                          "Source No." = field("Filter Fournisseur")));
            Description = 'Houcine';
            Editable = false;
            FieldClass = FlowField;
        }
        field(29; "Frais Contrôle Sanitaire"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Value Entry"."Cost Amount (Actual)" where("N° Dossier" = field("N° Dossier"),
                                                                          "Invoiced Quantity" = filter(0),
                                                                          "Valued Quantity" = filter(<> 0),
                                                                          //GL2024   "Type Frais" = filter(16),
                                                                          "Source Type" = filter(Vendor),
                                                                          "Source No." = field("Filter Fournisseur")));
            Description = 'Houcine';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Date Déclaration"; Date)
        {

            trigger OnValidate()
            begin
                //MBY 20/01/2012
                LigDossier.Reset;
                LigDossier.SetRange("N° dossier", "N° Dossier");
                if "Date Déclaration" <> 0D then
                    if LigDossier.Find('-') then
                        repeat
                            LigDossier."Date Déclaration" := "Date Déclaration";
                            LigDossier.Modify;
                        until LigDossier.Next = 0
                //MBY 20/01/2012
            end;
        }
        field(40; "Frais OPNT"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Value Entry"."Cost Amount (Actual)" where("N° Dossier" = field("N° Dossier"),
                                                                          "Invoiced Quantity" = filter(0),
                                                                          "Valued Quantity" = filter(<> 0),
                                                                          //GL2024   "Type Frais" = filter(17),
                                                                          "Source Type" = filter(Vendor),
                                                                          "Source No." = field("Filter Fournisseur")));
            Description = 'Houcine';
            Editable = false;
            FieldClass = FlowField;
        }
        field(41; "Frais STAM"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Value Entry"."Cost Amount (Actual)" where("N° Dossier" = field("N° Dossier"),
                                                                          "Invoiced Quantity" = filter(0),
                                                                          "Valued Quantity" = filter(<> 0),
                                                                          //GL2024  "Type Frais" = filter(18),
                                                                          "Source Type" = filter(Vendor),
                                                                          "Source No." = field("Filter Fournisseur")));
            Description = 'Houcine';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50; "N° dern Commande"; Code[20])
        {
            TableRelation = "Purchase Header"."No.";
            ValidateTableRelation = false;
        }
        field(58; "Frais Financiers en instance"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Item Charge Assignment (Purch)"."Montant associé" where("N° Dossier" = field("N° Dossier"),
                                                                                        "Type Frais" = filter("Frais Financiers"),
                                                                                        "Source Type" = filter(Vendor),
                                                                                        "Source No." = field("Filter Fournisseur")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "Assurances en Instance"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Item Charge Assignment (Purch)"."Montant associé" where("N° Dossier" = field("N° Dossier"),
                                                                                        "Type Frais" = filter(Assurances),
                                                                                        "Source Type" = filter(Vendor),
                                                                                        "Source No." = field("Filter Fournisseur")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "Magasinage en Instance"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Item Charge Assignment (Purch)"."Montant associé" where("N° Dossier" = field("N° Dossier"),
                                                                                        "Type Frais" = filter(Magasinage),
                                                                                        "Source Type" = filter(Vendor),
                                                                                        "Source No." = field("Filter Fournisseur")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Transit en instance"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Item Charge Assignment (Purch)"."Montant associé" where("N° Dossier" = field("N° Dossier"),
                                                                                        "Type Frais" = filter(Transit),
                                                                                        "Source Type" = filter(Vendor),
                                                                                        "Source No." = field("Filter Fournisseur")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Douane en Instance"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Item Charge Assignment (Purch)"."Montant associé" where("N° Dossier" = field("N° Dossier"),
                                                                                        "Type Frais" = filter(Douane),
                                                                                        "Source Type" = filter(Vendor),
                                                                                        "Source No." = field("Filter Fournisseur")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(78; "F. d'emb./ mise à FOB en inst."; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Item Charge Assignment (Purch)"."Montant associé DS" where("N° Dossier" = field("N° Dossier"),
                                                                                           "Type Frais" = filter("Frais d'emballage / mise à FOB"),
                                                                                           "Source Type" = filter(Vendor),
                                                                                           "Source No." = field("Filter Fournisseur")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(79; "Frêt en instance"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Item Charge Assignment (Purch)"."Montant associé DS" where("N° Dossier" = field("N° Dossier"),
                                                                                           "Type Frais" = filter(Frèt),
                                                                                           "Source Type" = filter(Vendor),
                                                                                           "Source No." = field("Filter Fournisseur")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(80; "Frais D'acconage en Instance"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Item Charge Assignment (Purch)"."Montant associé DS" where("N° Dossier" = field("N° Dossier"),
                                                                                           "Type Frais" = filter("Frais D'acconage"),
                                                                                           "Source Type" = filter(Vendor),
                                                                                           "Source No." = field("Filter Fournisseur")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(81; "Dif. Change en Instance"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Item Charge Assignment (Purch)"."Montant associé DS" where("N° Dossier" = field("N° Dossier"),
                                                                                           "Type Frais" = filter("Dif. Change"),
                                                                                           "Source Type" = filter(Vendor),
                                                                                           "Source No." = field("Filter Fournisseur")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(82; "Transport en Instance"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Item Charge Assignment (Purch)"."Montant associé DS" where("N° Dossier" = field("N° Dossier"),
                                                                                           "Type Frais" = filter(Transport),
                                                                                           "Source Type" = filter(Vendor),
                                                                                           "Source No." = field("Filter Fournisseur")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(84; "Frais Bancaires en Instance"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Item Charge Assignment (Purch)"."Montant associé DS" where("N° Dossier" = field("N° Dossier"),
                                                                                           "Type Frais" = filter("Frais Bancaires"),
                                                                                           "Source Type" = filter(Vendor),
                                                                                           "Source No." = field("Filter Fournisseur")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(85; "Etat et taxes en Instance"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Item Charge Assignment (Purch)"."Montant associé DS" where("N° Dossier" = field("N° Dossier"),
                                                                                           "Type Frais" = filter("Etat et taxes"),
                                                                                           "Source Type" = filter(Vendor),
                                                                                           "Source No." = field("Filter Fournisseur")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(86; "Autres Frais en Instance"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Item Charge Assignment (Purch)"."Montant associé DS" where("N° Dossier" = field("N° Dossier"),
                                                                                           "Type Frais" = filter("Autres Frais"),
                                                                                           "Source Type" = filter(Vendor),
                                                                                           "Source No." = field("Filter Fournisseur")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(87; "Frais Débarquement en instance"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Item Charge Assignment (Purch)"."Montant associé" where("N° Dossier" = field("N° Dossier"),
                                                                                        //GL2024 "Type Frais" = filter(15),
                                                                                        "Source Type" = filter(Vendor),
                                                                                        "Source No." = field("Filter Fournisseur")));
            Description = 'Houcine';
            Editable = false;
            FieldClass = FlowField;
        }
        field(88; "Frais Portuaire en instance"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Item Charge Assignment (Purch)"."Montant associé" where("N° Dossier" = field("N° Dossier"),
                                                                                         //GL2024 "Type Frais" = filter(14),
                                                                                         "Type Frais" = filter("Autres Frais"),
                                                                                        "Source Type" = filter(Vendor),
                                                                                        "Source No." = field("Filter Fournisseur")));
            Description = 'Houcine';
            Editable = false;
            FieldClass = FlowField;
        }
        field(89; "Frais Ctrl Sanit. en instance"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Item Charge Assignment (Purch)"."Montant associé" where("N° Dossier" = field("N° Dossier"),
                                                                                        //GL2024   "Type Frais" = filter(16),
                                                                                        "Source Type" = filter(Vendor),
                                                                                        "Source No." = field("Filter Fournisseur")));
            Description = 'Houcine';
            Editable = false;
            FieldClass = FlowField;
        }
        field(90; "Frais OPNT en instance"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Item Charge Assignment (Purch)"."Montant associé" where("N° Dossier" = field("N° Dossier"),
                                                                                        //GL2024  "Type Frais" = filter(17),
                                                                                        "Source Type" = filter(Vendor),
                                                                                        "Source No." = field("Filter Fournisseur")));
            Description = 'Houcine';
            Editable = false;
            FieldClass = FlowField;
        }
        field(91; "Frais STAM en instance"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Item Charge Assignment (Purch)"."Montant associé" where("N° Dossier" = field("N° Dossier"),
                                                                                        //GL2024   "Type Frais" = filter(18),
                                                                                        "Source Type" = filter(Vendor),
                                                                                        "Source No." = field("Filter Fournisseur")));
            Description = 'Houcine';
            Editable = false;
            FieldClass = FlowField;
        }
        field(100; "N° Transitaire"; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(101; "Nom Transitaire"; Text[60])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("N° Transitaire")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(102; Addresse; Text[60])
        {
            CalcFormula = lookup(Vendor.Address where("No." = field("N° Fournisseur")));
            Description = 'Houcine';
            Editable = false;
            FieldClass = FlowField;
        }
        field(103; "Addresse 2"; Text[60])
        {
            CalcFormula = lookup(Vendor."Address 2" where("No." = field("N° Fournisseur")));
            Description = 'Houcine';
            Editable = false;
            FieldClass = FlowField;
        }
        field(104; Ville; Text[30])
        {
            CalcFormula = lookup(Vendor.City where("No." = field("N° Fournisseur")));
            Description = 'Houcine';
            Editable = false;
            FieldClass = FlowField;
        }
        field(105; "Code postale"; Code[20])
        {
            CalcFormula = lookup(Vendor."Post Code" where("No." = field("N° Fournisseur")));
            Description = 'Houcine';
            Editable = false;
            FieldClass = FlowField;
        }
        field(200; "Filter Fournisseur"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(201; "N° Transit Externe"; Code[20])
        {
        }
        field(202; "Gain de change"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Document Type" = filter(" "),
                                                                                  "N° Dossier" = field("N° Dossier"),
                                                                                  "Vendor No." = field("N° Fournisseur"),
                                                                                  "Amount (LCY)" = filter(> 0),
                                                                                  "Entry Type" = filter("Realized Gain")));
            FieldClass = FlowField;
        }
        field(203; "Perte de change"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Document Type" = filter(" "),
                                                                                  "N° Dossier" = field("N° Dossier"),
                                                                                  "Vendor No." = field("N° Fournisseur"),
                                                                                  "Amount (LCY)" = filter(< 0),
                                                                                  "Entry Type" = filter("Realized Loss")));
            FieldClass = FlowField;
        }
        field(204; "Commisions Bancaires"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Value Entry"."Cost Amount (Actual)" where("N° Dossier" = field("N° Dossier"),
                                                                          "Invoiced Quantity" = filter(0),
                                                                          "Valued Quantity" = filter(<> 0),
                                                                          "Type Frais" = filter("Frais Bancaires")));
            Description = 'IBA 16/06/2011';
            Editable = false;
            FieldClass = FlowField;
        }
        field(205; "Commisions Bancaires instance"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Item Charge Assignment (Purch)"."Montant associé" where("N° Dossier" = field("N° Dossier"),
                                                                                        "Type Frais" = filter("Frais Bancaires"),
                                                                                        "Source Type" = filter(Vendor),
                                                                                        "Source No." = field("Filter Fournisseur")));
            Description = 'IBA 16/06/2011';
            Editable = false;
            FieldClass = FlowField;
        }
        field(206; Montant; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Ligne Dossiers d'Importation".Montant where("N° dossier" = field("N° Dossier")));
            Description = 'IBA 16/06/2011';
            Editable = false;
            FieldClass = FlowField;
        }
        field(207; "Date Echéance"; Date)
        {
            Description = 'IBA 16/06/2011';
        }
        field(208; "Date Echéance1"; Date)
        {
            Description = 'IBA 16/06/2011';
        }
        field(209; "Date Echéance2"; Date)
        {
            Description = 'IBA 16/06/2011';
        }
        field(210; "Date Echéance3"; Date)
        {
            Description = 'IBA 16/06/2011';
        }
        field(211; "Date Echéance4"; Date)
        {
            Description = 'IBA 16/06/2011';
        }
        field(212; Financement; Decimal)
        {
            Description = 'IBA 16/06/2011';
        }
        field(213; Financement1; Decimal)
        {
            Description = 'IBA 16/06/2011';
        }
        field(214; Financement2; Decimal)
        {
            Description = 'IBA 16/06/2011';
        }
        field(215; Financement3; Decimal)
        {
            Description = 'IBA 16/06/2011';
        }
        field(216; Financement4; Decimal)
        {
            Description = 'IBA 16/06/2011';
        }
        field(217; "Montant intérêt"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'IBA 20/07/2011';
        }
        field(218; "Montant intérêt1"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'IBA 20/07/2011';
        }
        field(219; "Montant intérêt2"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'IBA 20/07/2011';
        }
        field(220; "Montant intérêt3"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'IBA 20/07/2011';
        }
        field(221; "Montant intérêt4"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'IBA 20/07/2011';
        }
        field(50000; "N° Facture fournisseur"; Code[20])
        {
            Description = 'MBY 29/11/2011';
        }
        field(50001; Colisage1; Text[60])
        {
            Description = 'MBY 29/11/2011';
        }
        field(50002; Colisage2; Text[60])
        {
            Description = 'MBY 29/11/2011';
        }
        field(50003; Colisage3; Text[60])
        {
            Description = 'MBY 29/11/2011';
        }
        field(50004; "N° Titre d'importation"; Code[20])
        {
            Description = 'MBY 29/11/2011';
        }
        field(50005; "Date Titre d'importation"; Date)
        {
            Description = 'MBY 29/11/2011';
        }
        field(50006; "Marge sur Vente"; Decimal)
        {
            Description = 'MBY 04/01/2012';

            trigger OnValidate()
            begin
                /*
                RecUser.RESET;
                IF RecUser.GET(USERID) THEN
                  IF NOT RecUser."Modif Prix" THEN
                    ERROR(error01)
                 */

            end;
        }
        field(50007; "Facteur Devise"; Decimal)
        {
            DecimalPlaces = 3 : 5;
            Description = 'MBY 20/01/2012';
        }
        field(50008; Synchronise; Boolean)
        {
        }
    }

    keys
    {
        key(STG_Key1; "N° Dossier")
        {
            Clustered = true;
        }
        key(STG_Key2; "Date d'ouverture")
        {
        }
        key(STG_Key3; "N° Transitaire", "Date Déclaration", "N° Dossier")
        {
        }
        key(STG_Key4; Synchronise)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //* NSC1.08 :Destruction des Bons de reception liés
        BonReceptions.Reset;
        BonReceptions.SetRange("N° Dossier", "N° Dossier");
        if BonReceptions.Find('-') then
            repeat
                BonReceptions.Delete(true);
            until BonReceptions.Next = 0;
        //* FIN NSC1.08 :Destruction des Bons de reception liés

        LigDossier.Reset;
        LigDossier.SetRange("N° dossier", "N° Dossier");
        if LigDossier.Find('-') then
            Error(
              'Vous ne pouvez pas supprimer le %1 %2 car il y a des %3 liées à ce %1.',
              TableName, "N° Dossier", LigDossier.TableName);

        EcrArt.Reset;
        EcrArt.SetRange("N° dossier", "N° Dossier");
        if EcrArt.Find('-') then
            Error(
              'Vous ne pouvez pas supprimer le %1 %2 car il y a des %3 liées à ce %1.',
              TableName, "N° Dossier", EcrArt.TableName);

        EnteteAchat.Reset;
        EnteteAchat.SetRange("N° Dossier", "N° Dossier");
        if EnteteAchat.Find('-') then
            Error(
              'Vous ne pouvez pas supprimer le %1 %2 car il y a des %3 liées à ce %1.',
              TableName, "N° Dossier", EnteteAchat.TableName);
    end;

    trigger OnInsert()
    begin
        if "N° Dossier" = '' then begin
            if RecPurchasesPayablesSetup.Get then;
            // ParamStock.TESTFIELD("N° dossier");
            GestionNoSouche.InitSeries(RecPurchasesPayablesSetup."Transit File Nos.", xRec."Souches de N°", 0D, "N° Dossier", "Souches de N°");
        end;

        "Date d'ouverture" := WorkDate;
    end;

    var
        EnteteAchat: Record "Purchase Header";
        EcrArt: Record "Item Ledger Entry";
        RecPurchasesPayablesSetup: Record "Purchases & Payables Setup";
        LigDossier: Record "Ligne Dossiers d'Importation";
        FactureAchat: Record "Purch. Inv. Header";
        GestionNoSouche: Codeunit 396;
        NoArticlePrec: Code[20];
        NoCalcul: Integer;
        BonReceptions: Record "Purch. Rcpt. Header";
        m: Integer;
        numdoc: Code[20];
        gestsouche: Codeunit 396;
        NomFeuilleCpta: Record "Gen. Journal Batch";
        ligdosTmp: Record "Ligne Dossiers d'Importation";
        Art: Record Item;
        LDoss: Record "Ligne Dossiers d'Importation";
        LigFacture: Record "Purch. Inv. Line";
        EntFact: Record "Purch. Inv. Header";
        VAlEntry: Record "Value Entry";
        Frs: Record Vendor;
        RecUser: Record "User Setup";
        error01: label 'Vous n''êtes pas autorisez de modifier la marge sur vente, Contactez l''administrateur du systeme';


    procedure "VérifEcrtCpta"()
    var
        EcrtCpta: Record "G/L Entry";
        LigFscpta: Record "Gen. Journal Line";
    begin
        /*CLEAR(EcrtCpta);
          EcrtCpta.RESET;
         EcrtCpta.SETFILTER("N° Dossier", "N° dossier");
        IF EcrtCpta.FIND('-') THEN
          ERROR('Vous ne pouvez pas modifier l''état de dossier N° %1....',"N° dossier");
          CLEAR(LigFscpta);
        LigFscpta.RESET;
        LigFscpta.SETFILTER("N° Dossier","N° dossier");
        IF LigFscpta.FIND('-') THEN
          LigFscpta.DELETEALL;
        LigFscptaB.RESET;
        LigFscptaB.SETFILTER("N° Dossier","N° dossier");
        IF LigFscptaB.FIND('-') THEN
          LigFscptaB.DELETEALL;
        */

    end;


    procedure FraisApproche() Frais: Decimal
    begin
        CalcFields("Frêt en instance", Frêt, "Transit en instance", Transit, "Montant (dev Soc)", Magasinage, "Magasinage en Instance",
        "Dif. Change en Instance", "Dif. Change", Transport, "Transport en Instance");
        LigDossier.Reset;
        LigDossier.SetFilter("N° dossier", "N° Dossier");
        LigDossier.SetFilter("N° article", '<>''''');
        if LigDossier.Find('-') then begin
            if ("Montant (dev Soc)" + Frêt + "Frêt en instance") <> 0 then
                Frais := ((Transit + Magasinage + "Dif. Change" + Transport + "Transit en instance" + "Magasinage en Instance" + "Dif. Change en Instance" +
                "Transport en Instance") / ("Montant (dev Soc)" + Frêt + "Frêt en instance")) * 100
            else
                Frais := 0;
        end;
    end;


    procedure "RecalculerCoût"()
    var
        ligdoss: Record "Ligne Dossiers d'Importation";
        dev: Record "Currency Exchange Rate";
    begin

        ligdoss.Reset;
        ligdoss.SetFilter("N° dossier", "N° Dossier");
        if ligdoss.Find('-') then
            repeat
                if ligdoss."Code devise" <> '' then begin
                    if Format("Date Déclaration") = '' then
                        Error('Voulez devez saisir la date de déclaration doûane !');

                    ligdoss."Coût unitaire (dev soc)" := dev.ExchangeAmtFCYToLCY("Date Déclaration", ligdoss."Code devise",
                    ligdoss."Coût unitaire", dev.ExchangeRate("Date Déclaration", ligdoss."Code devise"));
                    ligdoss."Montant (dev soc)" := dev.ExchangeAmtFCYToLCY("Date Déclaration", ligdoss."Code devise",
                    ligdoss.Montant, dev.ExchangeRate("Date Déclaration", ligdoss."Code devise"));
                    ligdoss."Facteur devise" := dev.ExchangeRate("Date Déclaration", ligdoss."Code devise");
                    ligdoss.Modify;
                end;
            until ligdoss.Next = 0;
    end;


    procedure "%FretM"() "%f": Decimal
    begin
        CalcFields(Frêt, "Frêt en instance", Transit, "Transit en instance", "Montant (dev Soc)", Magasinage, "Magasinage en Instance",
        "Dif. Change en Instance", "Dif. Change", Transport, "Transport en Instance");
        if "Montant (dev Soc)" <> 0 then
            "%f" := ((Frêt + "Frêt en instance") / "Montant (dev Soc)") * 100
        else
            "%f" := 0;
    end;


    procedure "CalcCoût"()
    begin
        /*clear(ligdosTmp);
        ligdosTmp.reset;
        ligdosTmp.setfilter("N° dossier","N° dossier");
        if ligdosTmp.find('-') then
          repeat
            clear(Art);
            Art.get(ligdosTmp."N° article");
            clear(Ldoss);
            Ldoss.reset;
            Ldoss.setcurrentkey("N° article","Date Déclaration","N° dossier");
            Ldoss.setfilter("N° article",ligdosTmp."N° article");
            Ldoss.setfilter("Date Déclaration",'%1..',"Date Déclaration");
            Ldoss.setfilter("N° dossier",'<>%1',"N° dossier");
            if not Ldoss.Find('-') then begin
              Art."N° Dossier (PRR)":="N° dossier";
              Art."Date dossier (PRR)":="Date d'ouverture";
              Art."Dernier PA en Devise":=
              Art.DPRR:= */

    end;


    procedure ActualiserLignesFactures()
    begin
        ligdosTmp.Reset;
        ligdosTmp.SetFilter("N° dossier", "N° Dossier");
        if ligdosTmp.Find('-') then
            repeat
                LigFacture.Reset;
                LigFacture.SetCurrentkey("N° Bon Reception", "N° Ligne Bon Reception", Type, "No.");
                LigFacture.SetFilter("N° Bon Reception", ligdosTmp."N° réception");
                LigFacture.SetRange("N° Ligne Bon Reception", ligdosTmp."N° ligne réception");
                if LigFacture.Find('-') then begin
                    LigFacture."N° dossier" := "N° Dossier";
                    EntFact.Reset;
                    EntFact.Get(LigFacture."Document No.");

                    if LigFacture.Modify then begin
                        EntFact."N° Dossier" := "N° Dossier";
                        EntFact."Date vérification" := "Date Déclaration";
                        EntFact.Modify;
                    end;
                    VAlEntry.Reset;
                    VAlEntry.SetCurrentkey("N° Réception", "N° Ligne Réception", "Entry No.");
                    VAlEntry.SetFilter("N° Réception", ligdosTmp."N° réception");
                    VAlEntry.SetRange("N° Ligne Réception", ligdosTmp."N° ligne réception");
                    if VAlEntry.Find('-') then
                        VAlEntry.ModifyAll("N° Dossier", "N° Dossier");
                end;
            until ligdosTmp.Next = 0;
    end;


    procedure AnnActualiserLignesFactures()
    begin
        ligdosTmp.Reset;
        ligdosTmp.SetFilter("N° dossier", "N° Dossier");
        if ligdosTmp.Find('-') then
            repeat
                LigFacture.Reset;
                LigFacture.SetCurrentkey("N° Bon Reception", "N° Ligne Bon Reception", Type, "No.");
                LigFacture.SetFilter("N° Bon Reception", ligdosTmp."N° réception");
                LigFacture.SetRange("N° Ligne Bon Reception", ligdosTmp."N° ligne réception");
                if LigFacture.Find('-') then begin
                    LigFacture."N° dossier" := '';
                    EntFact.Reset;
                    if EntFact.Get(LigFacture."Document No.") then
                        if LigFacture.Modify then begin
                            EntFact."N° Dossier" := '';
                            EntFact."Date vérification" := 0D;
                            EntFact.Modify;
                        end;
                end;
            until ligdosTmp.Next = 0;
    end;
}

