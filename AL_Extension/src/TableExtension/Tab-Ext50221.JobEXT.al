TableExtension 50221 JobEXT extends Job
{
    /*GL2024Permissions=TableData 21=rm,
                   TableData 8004161=rm;*/
    fields
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                //JOB_TOTALING
                lSetJobTotalingField(Rec);
                lSetJobTotalingLevel(Rec);
                //JOB_TOTALING//


            end;
        }
        modify("Job Posting Group")
        {

            trigger OnAfterValidate()
            begin
                //JOB_POSTING
                if "Job Posting Group" <> xRec."Job Posting Group" then
                    if wEntryExists then
                        FieldError("Job Posting Group", tNotEmpty);
                //JOB_POSTING//
            end;
        }
        field(50000; Synchronise; Boolean)
        {
        }
        field(50001; "Num Sequence Syncro"; Integer)
        {
        }
        field(50002; "Apply entries"; Integer)
        {
            CalcFormula = count("Job Ledger Entry2" where("Job No." = field("No."),
                                                          Balanced = const(false)));
            Caption = 'Open Entries Count';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Affaire Par Defaut"; Boolean)
        {
            Description = 'HJ DSFT 31-JANV-2012';
        }
        field(50005; "Affectation Magasin"; Code[20])
        {
            Description = 'RB SORO 19/06/2015';
            TableRelation = Location;
        }
        field(50006; "No. Series Caisse"; Code[20])
        {
            TableRelation = "No. Series";
            Caption = 'N° de Souche Caisse';
        }
        field(50007; "% Marge"; Decimal)
        {

            Caption = '% Marge';
        }
        field(50008; "No. Series Pointage Vehicule"; code[50])
        {
            Caption = 'N° de Souche Pointage Vehicule';
            TableRelation = "No. Series";
        }
        field(50009; "Fond de Roulement Caisse"; Decimal)
        {
            Caption = 'Fond de Roulement Caisse';
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Ledger Entry".Amount where("Bank Account No." = const('CA001001'), "Global Dimension 1 Code" = field("No."), "Reason Code" = const('BFR')));
            Editable = false;
        }
        field(50010; "Depenses Caisse"; Decimal)
        {
            Caption = 'Depenses Caisse';
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Ledger Entry".Amount where("Bank Account No." = const('CA001001'), "Global Dimension 1 Code" = field("No."), "Reason Code" = filter('<>BFR')));
            Editable = false;
        }
        field(50300; "Short Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Short Dimension 3 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(50301; "Short Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Short Dimension 4 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));


        }
        field(50302; "Short Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Short Dimension 5 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));


        }
        field(50303; "Short Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Short Dimension 6 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));


        }
        field(50304; "Short Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Short Dimension 7 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));


        }
        field(50305; "Short Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Short Dimension 8 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));


        }
        //<<ABZ 
        /* field(50007; "Remblais Valoriser"; Boolean)
         {
             Description = 'HJ SORO 06-06-2017';
         }
         field(50008; "Deblais Valoriser"; Boolean)
         {
             Description = 'HJ SORO 06-06-2017';
         }
         field(50009; "Société"; Code[20])
         {
             TableRelation = "Entete rapport DG";
         }
         field(50010; "Correspandant Client"; Code[20])
         {
             Description = 'MH SORO 27-02-2018';
             TableRelation = Customer;
         }
         field(50011; "Activer Procedure DA"; Boolean)
         {
             Description = 'HJ SORO 06-03-2018';
         }*/

        field(82750; "Mask Code"; Code[10])
        {
            Caption = 'Mask Code';
            TableRelation = Mask;

            trigger OnValidate()
            var
            // lMaskMgt: Codeunit "Mask Management";
            begin
                //MASK
                //GL2024     lMaskMgt.JobMaskValidate(xRec, Rec);
                //MASK//
            end;
        }
        field(8001301; "Criteria 1"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99090';
            Caption = 'Criteria 1';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001301));
        }
        field(8001302; "Criteria 2"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99091';
            Caption = 'Criteria 2';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001302));
        }
        field(8001303; "Criteria 3"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99092';
            Caption = 'Criteria 3';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001303));
        }
        field(8001304; "Criteria 4"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99093';
            Caption = 'Criteria 4';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001304));
        }
        field(8001305; "Criteria 5"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99094';
            Caption = 'Criteria 5';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001305));
        }
        field(8001306; "Criteria 6"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99095';
            Caption = 'Criteria 6';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001306));
        }
        field(8001307; "Criteria 7"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99096';
            Caption = 'Criteria 7';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001307));
        }
        field(8001308; "Criteria 8"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99097';
            Caption = 'Criteria 8';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001308));
        }
        field(8001309; "Criteria 9"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99098';
            Caption = 'Criteria 9';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001309));
        }
        field(8001310; "Criteria 10"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99099';
            Caption = 'Criteria 10';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001310));
        }
        field(8001400; "Gen. Prod Posting Group Filter"; Code[10])
        {
            Caption = 'Gen. Prod Posting Group Filter';
            FieldClass = FlowFilter;
            TableRelation = "Gen. Product Posting Group";
        }
        field(8001403; "Purch. Engaged"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Purchase Line"."Engaged Cost (LCY)" where("Document Type" = const(Order),
                                                                          "Job No." = field("No."),
                                                                          "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter"),
                                                                          "Serial No." = field("Work Type Filter"),
                                                                          "Order Date" = field("Posting Date Filter")));
            Caption = 'Purchase Engaged';
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
        }
        field(8003900; Level; Integer)
        {
            Caption = 'Level';
        }
        field(8003901; "Last Audit Date"; Date)
        {
            Caption = 'Last Audit Date';
        }
        field(8003902; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            var
                // lSingleinstance: Codeunit "Import SingleInstance2";
                Text010: label 'Do you want to continue?';
                Text027: label 'Your identification is set up to process from %1 %2 only.';
                lUserMgt: Codeunit "User Setup Management";
                lRespCenter: Record "Responsibility Center";
                tRespCenter: label '%1 modification can change the numbering.';
            begin
                if not lUserMgt.CheckRespCenter(0, "Responsibility Center") then
                    Error(
                      Text027,
                      lRespCenter.TableCaption, lUserMgt.GetSalesFilter());
                //AGENCE
                if (xRec."Responsibility Center" <> "Responsibility Center") then
                    if not Confirm(tRespCenter + Text010, false, FieldCaption("Responsibility Center")) then
                        Error('');
                //AGENCE//
            end;
        }
        field(8003903; "Recognition Date"; Date)
        {
            Caption = 'Recognition Date';
            Description = 'Modif Editable Oui';
            Editable = true;

            trigger OnValidate()
            var
                lCustLedgEntry: Record "Cust. Ledger Entry";
                lGuarantee: Record "Guarantee Entry";
                lRetention: Record Retention;
            begin
                //RECEPTION
                TestField(Finished, true);
                if ("Recognition Date" <> xRec."Recognition Date") and ("Recognition Date" <> 0D) then begin
                    lCustLedgEntry.SetCurrentkey("Document Type", "Document No.", "Retention Code", "Job No.", Open);
                    lCustLedgEntry.SetFilter("Retention Code", '<>%1', '');
                    lCustLedgEntry.SetRange("Job No.", "No.");
                    lCustLedgEntry.SetRange(Open, true);
                    if lCustLedgEntry.Find('-') then
                        repeat
                            lRetention.Get(lCustLedgEntry."Retention Code");
                            lCustLedgEntry."Due Date" := CalcDate(lRetention."Due Date Calculation", "Recognition Date");
                            lCustLedgEntry."On Hold" := '';
                            lCustLedgEntry.Modify;
                        until lCustLedgEntry.Next = 0;
                    lGuarantee.SetCurrentkey("Job No.");
                    lGuarantee.SetRange("Job No.", "No.");
                    lGuarantee.SetRange(Open, true);
                    lGuarantee.ModifyAll("Closed Date", CalcDate('<+1Y>', "Recognition Date"));
                end;
                //RECEPTION//
            end;
        }
        field(8003908; "Initial Gross Total Cost"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Gross Total Cost" where("Job No." = field("No."),
                                                                            "Planning Date" = field("Posting Date Filter"),
                                                                            "Entry Type" = const(Initial),
                                                                            "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter")));
            Caption = 'Initial Gross Total Cost';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003909; "Job Totaling"; Code[50])
        {
            Caption = 'Job Totaling';
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(8003910; "Job Address"; Text[50])
        {
            Caption = 'Job Address';
        }
        field(8003911; "Job Address 2"; Text[50])
        {
            Caption = 'Job Address 2';
        }
        field(8003912; "Job City"; Text[30])
        {
            Caption = 'Job City';

            trigger OnLookup()
            begin
                //GL2024 "Le procedure n'existe pas dans BC24     wPostCode.LookUpCity("Job City", "Job Post Code", true);

            end;

            trigger OnValidate()
            begin
                //GL2024 wPostCode.ValidateCity("Job City", "Job Post Code");
                PostCode.ValidateCity("Job City", "Job Post Code", "Job County", "Job Country Code", true);
            end;
        }
        field(8003913; "Job County"; Text[30])
        {
            Caption = 'Job County';
        }
        field(8003914; "Job Post Code"; Code[20])
        {
            Caption = 'Job Post Code';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //GL2024 wPostCode.LookUpPostCode("Job City", "Job Post Code", true);
                wPostCode.LookUpPostCode("Job City", "Job Post Code", "Job County", "Job Country Code");
            end;

            trigger OnValidate()
            begin
                //GL2024  wPostCode.ValidatePostCode("Job City", "Job Post Code");
                wPostCode.ValidatePostCode("Job City", "Job Post Code", "Job County", "Job Country Code", true);
            end;
        }
        field(8003915; "Job Country Code"; Code[10])
        {
            Caption = 'Job Country Code';
            TableRelation = "Country/Region";
        }
        field(8003916; Subject; Text[50])
        {
            Caption = 'Object';
        }
        field(8003917; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(8003918; "Distribution Type (Planning)"; Option)
        {
            Caption = 'Distribution Type (Planning)';
            OptionCaption = 'Manual,Prorata temporis,Normal Curve';
            OptionMembers = Manual,"Prorata temporis","Normal Curve";
        }
        field(8003919; "Estimated invoicing"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Estimated invoicing".Amount where("Job No." = field("No."),
                                                                  "Posting Date" = field("Posting Date Filter"),
                                                                  "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter"),
                                                                  "Doc. Type" = field("Document Type Filter")));
            Caption = 'Estimated invoicing';
            FieldClass = FlowField;
        }
        field(8003920; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            Editable = false;
            TableRelation = "IC Partner";

            trigger OnValidate()
            var
                ICPartner: Record "IC Partner";
            begin
            end;
        }
        field(8003924; "Posted In Period"; Boolean)
        {
            CalcFormula = exist("Job Ledger Entry2" where("Job No." = field("No."),
                                                          "Posting Date" = field("Posting Date Filter")));
            Caption = 'Posted In Period';
            FieldClass = FlowField;
        }
        field(8003925; Finished; Boolean)
        {
            Caption = 'Finished';

            trigger OnValidate()
            begin
                //#6583
                if Finished and not xRec.Finished and (Blocked = Blocked::" ") then
                    Blocked := Blocked::All;
                //#6583//
            end;
        }
        field(8003926; "Travel Code"; Code[10])
        {
            Caption = 'Travel Code';
            TableRelation = "Travel Code";
        }
        field(8003928; "Working Time Res. Qty."; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Journal Line2"."Quantity (Base)" where("Job No." = field("No."),
                                                                          Type = const(Resource),
                                                                          "No." = field("Resource Filter"),
                                                                          "Posting Date" = field("Posting Date Filter"),
                                                                          "Journal Template Name" = field("Journal Template Name Filter"),
                                                                          "Journal Batch Name" = field("Journal Batch Name Filter"),
                                                                          "Work Type Code" = field("Work Type Filter"),
                                                                          "Work Time Type" = filter("Producted Hours" | "Unproduced Hours" | "Absence Hours")));
            Caption = 'Budgeted Res. Qty.';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
        }
        field(8003929; "Work Type Filter"; Code[10])
        {
            Caption = 'Work Type Filter';
            FieldClass = FlowFilter;
            TableRelation = "Work Type";
        }
        field(8003930; "Journal Template Name Filter"; Code[10])
        {
            Caption = 'Journal Template Name';
            FieldClass = FlowFilter;
            TableRelation = "Job Journal Template2";
        }
        field(8003931; "Journal Batch Name Filter"; Code[10])
        {
            Caption = 'Journal Batch Name';
            FieldClass = FlowFilter;
            TableRelation = "Job Journal Batch2".Name where("Journal Template Name" = field("Journal Template Name Filter"));
        }
        field(8003932; "Document Type Filter"; Option)
        {
            Caption = 'Document Type Filter';
            FieldClass = FlowFilter;
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(8003933; Summarize; Boolean)
        {
            Caption = 'Total';

            trigger OnValidate()
            begin
                //+JOB+TOTALISATION
                lSetJobTotalingField(Rec);
                //+JOB+TOTALISATION//
            end;
        }
        field(8003940; "Job Type"; Option)
        {
            Caption = 'Job Type';
            OptionCaption = 'External,Internal,Stock';
            OptionMembers = External,Internal,Stock;
        }
        field(8003947; "Person Responsible 2"; Code[20])
        {
            //CaptionClass = wGetCaptionNaviBat(8003947);
            Caption = 'Person Responsible 2';
            TableRelation = Resource where(Type = const(Person));

            trigger OnLookup()
            var
                lResource: Record Resource;
            begin
                //#8356
                lResource.SetRange(Type, lResource.Type::Person);
                //#8356//
                //#7476
                lResource.SetRange(Status, lResource.Status::Internal);
                if PAGE.RunModal(0, lResource) = Action::LookupOK then
                    "Person Responsible 2" := lResource."No.";
                //"7476//
            end;
        }
        field(8003948; "Person Responsible 3"; Code[20])
        {
            //CaptionClass = wGetCaptionNaviBat(8003948);
            Caption = 'Person Responsible 3';
            TableRelation = Resource where(Type = const(Person));

            trigger OnLookup()
            var
                lResource: Record Resource;
            begin
                //#8356
                lResource.SetRange(Type, lResource.Type::Person);
                //#8356//
                //#7476
                lResource.SetRange(Status, lResource.Status::Internal);
                if PAGE.RunModal(0, lResource) = Action::LookupOK then
                    "Person Responsible 3" := lResource."No.";
                //"7476//
            end;
        }
        field(8003949; "Person Responsible 4"; Code[20])
        {
            //CaptionClass = wGetCaptionNaviBat(8003949);
            Caption = 'Person Responsible 4';
            TableRelation = Resource where(Type = const(Person),
                                            Status = const(Internal));

            trigger OnLookup()
            var
                lResource: Record Resource;
            begin
                //#8356
                lResource.SetRange(Type, lResource.Type::Person);
                //#8356//
                //#7476
                lResource.SetRange(Status, lResource.Status::Internal);
                if PAGE.RunModal(0, lResource) = Action::LookupOK then
                    "Person Responsible 4" := lResource."No.";
                //"7476//
            end;
        }
        field(8003950; "Person Responsible 5"; Code[20])
        {
            //CaptionClass = wGetCaptionNaviBat(8003950);
            Caption = 'Person Responsible 5';
            TableRelation = Resource where(Type = const(Person),
                                            Status = const(Internal));

            trigger OnLookup()
            var
                lResource: Record Resource;
            begin
                //#8356
                lResource.SetRange(Type, lResource.Type::Person);
                //#8356//
                //#7476
                lResource.SetRange(Status, lResource.Status::Internal);
                if PAGE.RunModal(0, lResource) = Action::LookupOK then
                    "Person Responsible 5" := lResource."No.";
                //"7476//
            end;
        }
        field(8003951; "Free Text 1"; Text[30])
        {
            //CaptionClass = wGetCaptionNaviBat(8003951);
            Caption = 'Free Text 1';
        }
        field(8003952; "Free Text 2"; Text[30])
        {
            //CaptionClass = wGetCaptionNaviBat(8003952);
            Caption = 'Free Text 2';
        }
        field(8003953; "Free Text 3"; Text[30])
        {
            //CaptionClass = wGetCaptionNaviBat(8003953);
            Caption = 'Free Text 3';
        }
        field(8003954; "Free Text 4"; Text[30])
        {
            //CaptionClass = wGetCaptionNaviBat(8003954);
            Caption = 'Free Text 4';
        }
        field(8003955; "Free Text 5"; Text[30])
        {
            //CaptionClass = wGetCaptionNaviBat(8003955);
            Caption = 'Free Text 5';
        }
        field(8003966; "Free Date 1"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003966);
            Caption = 'Free Date 1';
        }
        field(8003967; "Free Date 2"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003967);
            Caption = 'Free Date 2';
        }
        field(8003968; "Free Date 3"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003968);
            Caption = 'Free Date 3';
        }
        field(8003969; "Free Date 4"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003969);
            Caption = 'Free Date 4';
        }
        field(8003970; "Free Date 5"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003970);
            Caption = 'Free Date 5';
        }
        field(8003971; "Free Date 6"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003971);
            Caption = 'Free Date 6';
        }
        field(8003972; "Free Date 7"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003972);
            Caption = 'Free Date 7';
        }
        field(8003973; "Free Date 8"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003973);
            Caption = 'Free Date 8';
        }
        field(8003974; "Free Date 9"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003974);
            Caption = 'Free Date 9';
        }
        field(8003975; "Free Date 10"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003975);
            Caption = 'Free Date 10';
        }
        field(8003976; "Free Value 1"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionNaviBat(8003976);
            Caption = 'Free Value 1';
        }
        field(8003977; "Free Value 2"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionNaviBat(8003977);
            Caption = 'Free Value 2';
        }
        field(8003978; "Free Value 3"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionNaviBat(8003978);
            Caption = 'Free Value 3';
        }
        field(8003979; "Free Value 4"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionNaviBat(8003979);
            Caption = 'Free Value 4';
        }
        field(8003980; "Free Value 5"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionNaviBat(8003980);
            Caption = 'Free Value 5';
        }
        field(8003981; "Free Boolean 1"; Boolean)
        {
            //CaptionClass = wGetCaptionNaviBat(8003981);
            Caption = 'Free Boolean 1';
        }
        field(8003982; "Free Boolean 2"; Boolean)
        {
            //CaptionClass = wGetCaptionNaviBat(8003982);
            Caption = 'Free Boolean 2';
        }
        field(8003983; "Free Boolean 3"; Boolean)
        {
            //CaptionClass = wGetCaptionNaviBat(8003983);
            Caption = 'Free Boolean 3';
        }
        field(8003984; "Free Boolean 4"; Boolean)
        {
            //CaptionClass = wGetCaptionNaviBat(8003984);
            Caption = 'Free Boolean 4';
        }
        field(8003985; "Free Boolean 5"; Boolean)
        {
            //CaptionClass = wGetCaptionNaviBat(8003985);
            Caption = 'Free Boolean 5';
        }
        field(8003986; "Job Status"; Code[10])
        {
            Caption = 'Status Code';
            TableRelation = "Job Status";

            trigger OnValidate()
            var
            //lJobStatusMgt: Codeunit "Job Status Management";
            begin
                /* //GL2024      if ("Job Status" <> xRec."Job Status") or (CurrFieldNo = 0) then
                         lJobStatusMgt.JobStatusChange(xRec, Rec);*/
            end;
        }
        field(8003987; "No. of prov. Acceptance"; Integer)
        {
            CalcFormula = count("Guarantee,Penalty & Acceptance" where("Job No." = field("No."),
                                                                        Type = filter("Provisional Acceptance")));
            Caption = 'No. of prov. Acceptance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003989; "Penalties Amount"; Decimal)
        {
            CalcFormula = sum("Guarantee,Penalty & Acceptance"."Amount LCY" where("Job No." = field("No."),
                                                                                   Type = filter(Penalty)));
            Caption = 'Penalties Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003992; "Forecast Cost"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Total Cost (LCY)" where("Job No." = field("No."),
                                                                            "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter"),
                                                                            "Entry Type" = const(Initial),
                                                                            "Planning Date" = field("Posting Date Filter")));
            Caption = 'Forecast Cost';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003993; "Guarantees Amount LCY"; Decimal)
        {
            CalcFormula = sum("Guarantee Entry"."Amount (LCY)" where("Job No." = field("No.")));
            Caption = 'Guarantees Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003994; "Person Forecast Quantity"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Quantity (Base)" where("Job No." = field("No."),
                                                                           "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter"),
                                                                           Type = const(Resource),
                                                                           "Resource Type" = const(Person),
                                                                           "Planning Date" = field("Posting Date Filter"),
                                                                           "Entry Type" = const(Initial)));
            Caption = 'Person Forecast Quantity';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003995; "Posted Quantity (Base)"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Ledger Entry2"."Quantity (Base)" where("Job No." = field("No."),
                                                                          "Entry Type" = const(Usage),
                                                                          Type = const(Resource),
                                                                          "Resource Group No." = field("Resource Gr. Filter"),
                                                                          "Posting Date" = field("Posting Date Filter")));
            Caption = 'Posted Quantity (Base)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003996; "Quantity Planned"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Quantity (Base)" where("Job No." = field("No."),
                                                                           Type = const(Resource),
                                                                           "Planning Date" = field("Posting Date Filter"),
                                                                           "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter"),
                                                                           "Resource Type" = const(Person)));
            Caption = 'Quantity Planned';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003997; "Amount Planned"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Total Cost (LCY)" where("Job No." = field("No."),
                                                                            "Planning Date" = field("Posting Date Filter"),
                                                                            "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter")));
            Caption = 'Amount Planned';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003998; "Forecast Cost Person"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Total Cost (LCY)" where("Job No." = field("No."),
                                                                            "Planning Date" = field("Posting Date Filter"),
                                                                            "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter"),
                                                                            "Entry Type" = const(Initial),
                                                                            Type = const(Resource),
                                                                            "Resource Type" = const(Person)));
            Caption = 'Forecast Cost Person';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003999; "Posted Cost Person"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Ledger Entry2"."Total Cost (LCY)" where("Job No." = field("No."),
                                                                           "Entry Type" = const(Usage),
                                                                           "Gen. Bus. Posting Group" = field("Gen. Prod Posting Group Filter"),
                                                                           "Posting Date" = field("Posting Date Filter"),
                                                                           Type = const(Resource),
                                                                           "Resource Type" = const(Person),
                                                                           "Work Type Code" = field("Work Type Filter"),
                                                                           "Work Time Type" = filter("Producted Hours" | "Unproduced Hours" | "Absence Hours"),
                                                                           "Bal. Created Entry" = const(false)));
            Caption = 'Posted Cost Person';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004000; "Planned Cost Person"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Total Cost (LCY)" where("Job No." = field("No."),
                                                                            "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter"),
                                                                            Type = const(Resource),
                                                                            "Resource Type" = const(Person),
                                                                            "Planning Date" = field("Posting Date Filter")));
            Caption = 'Planned Cost Person';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004001; "Person Planned Quantity"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Quantity (Base)" where("Job No." = field("No."),
                                                                           "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter"),
                                                                           "Planning Date" = field("Posting Date Filter"),
                                                                           Type = const(Resource),
                                                                           "Resource Type" = const(Person)));
            Caption = 'Person Planned Quantity';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004002; "Audit Forecast Cost Person"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Total Cost (LCY)" where("Job No." = field("No."),
                                                                            "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter"),
                                                                            "Entry Type" = filter(Initial .. Audit),
                                                                            Type = const(Resource),
                                                                            "Resource Type" = const(Person),
                                                                            "Planning Date" = field("Posting Date Filter")));
            Caption = 'Forecast Cost Person';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004003; "Audit Person Forecast Quantity"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Quantity (Base)" where("Job No." = field("No."),
                                                                           "Planning Date" = field("Posting Date Filter"),
                                                                           "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter"),
                                                                           Type = const(Resource),
                                                                           "Resource Type" = const(Person),
                                                                           "Entry Type" = filter(Initial .. Audit)));
            Caption = 'Person Forecast Quantity';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004004; "Global Dimension 1 Filter"; Code[20])
        {
            //CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(8004005; "Global Dimension 2 Filter"; Code[20])
        {
            //CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(8004008; "Analysis Filter"; Option)
        {
            Caption = 'Analysis Filter';
            FieldClass = FlowFilter;
            OptionCaption = 'Price,Cost,Quantity';
            OptionMembers = Price,Cost,Quantity;
        }
        field(8004009; "Ship-to Contact2"; Text[50])
        {
            Caption = 'Ship-to Contact';
        }
        field(8004010; "Schedule (Total Cost)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Total Cost (LCY)" where("Job No." = field("No."),
                                                                            "Schedule Line" = const(true),
                                                                            "Planning Date" = field("Planning Date Filter")));
            Caption = 'Schedule (Total Cost)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004011; "Schedule (Total Price)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Line Amount (LCY)" where("Job No." = field("No."),
                                                                             "Schedule Line" = const(true),
                                                                             "Planning Date" = field("Planning Date Filter")));
            Caption = 'Schedule (Total Price)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004012; "Usage (Total Cost)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            CalcFormula = sum("Job Ledger Entry2"."Total Cost (LCY)" where("Job No." = field("No."),
                                                                           "Entry Type" = const(Usage),
                                                                           "Posting Date" = field("Posting Date Filter")));
            Caption = 'Usage (Total Cost)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004013; "Usage (Total Price)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            CalcFormula = sum("Job Ledger Entry2"."Line Amount (LCY)" where("Job No." = field("No."),
                                                                            "Entry Type" = const(Usage),
                                                                            "Posting Date" = field("Posting Date Filter")));
            Caption = 'Usage (Total Price)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004014; "Contract (Total Cost)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Total Cost (LCY)" where("Job No." = field("No."),
                                                                            "Contract Line" = const(true),
                                                                            "Planning Date" = field("Planning Date Filter")));
            Caption = 'Contract (Total Cost)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004015; "Contract (Total Price)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Line Amount (LCY)" where("Job No." = field("No."),
                                                                             "Contract Line" = const(true),
                                                                             "Planning Date" = field("Planning Date Filter")));
            Caption = 'Contract (Total Price)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004016; "Contract (Invoiced Price)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            CalcFormula = - sum("Job Ledger Entry2"."Line Amount (LCY)" where("Job No." = field("No."),
                                                                             "Entry Type" = const(Sale),
                                                                             "Posting Date" = field("Posting Date Filter")));
            Caption = 'Contract (Invoiced Price)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004017; "Contract (Invoiced Cost)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            CalcFormula = - sum("Job Ledger Entry2"."Total Cost (LCY)" where("Job No." = field("No."),
                                                                            "Entry Type" = const(Sale),
                                                                            "Posting Date" = field("Posting Date Filter")));
            Caption = 'Contract (Invoiced Cost)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004074; "Initial Price Forecast"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Total Price (LCY)" where("Job No." = field("No."),
                                                                             "Planning Date" = field("Posting Date Filter"),
                                                                             "Entry Type" = const(Initial),
                                                                             "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter")));
            Caption = 'Initial Price Forecast';
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
        }
        field(8004130; "Period Planning Quantity"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Planning Entry".Quantity where("Job No." = field("No."),
                                                               Date = field("Planning Date Filter"),
                                                               "Resource Group No." = field("Resource Gr. Filter"),
                                                               "No." = field("Resource Filter"),
                                                               Status = filter(<> Deleted)));
            Caption = 'Planning Quantity';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;

            trigger OnLookup()
            var
                lPlaningEntryTmp: Record "Planning Entry" temporary;
                //DYS page addon non migrer
                // lForm: Page 8004130;
                lPlaFilter: Record "Planning Filter Header";
            begin
                lPlaningEntryTmp.SetFilter("Job No.", "No.");

                if GetFilter("Resource Gr. Filter") <> '' then
                    lPlaningEntryTmp.SetFilter("Resource Group No.", GetFilter("Resource Gr. Filter"));
                if GetFilter("Planning Date Filter") <> '' then
                    lPlaningEntryTmp.SetFilter(Date, GetFilter("Planning Date Filter"));
                if GetFilter("Resource Filter") <> '' then
                    lPlaningEntryTmp.SetFilter("No.", GetFilter("Resource Filter"));

                lPlaningEntryTmp.SetFilter(Status, '<>%1', lPlaningEntryTmp.Status::Deleted);
                // lForm.GetRecord(lPlaningEntryTmp);
                // lForm.SetTableview(lPlaningEntryTmp);
                // lForm.SetOnOpenForm();
                // lForm.SetShowHistory(false);

                // if lFORM.RunModal = Action::LookupOK then;
            end;
        }
        field(8004132; "Working Time Mode"; Option)
        {
            Caption = 'Working Time Mode';
            OptionCaption = ' ,Order Line';
            OptionMembers = " ","Order Line";
        }
        field(8004133; "Planning Quantity"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Planning Entry".Quantity where("Job No." = field("No."),
                                                               "Resource Group No." = field("Resource Gr. Filter"),
                                                               "No." = field("Resource Filter"),
                                                               Status = filter(<> Deleted)));
            Caption = 'Planning Quantity';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;

            trigger OnLookup()
            var
                lPlaningEntryTmp: Record "Planning Entry" temporary;
                //DYS page addon non migrer
                // lForm: Page 8004130;
                lPlaFilter: Record "Planning Filter Header";
            begin
                lPlaningEntryTmp.SetFilter("Job No.", "No.");

                if GetFilter("Resource Gr. Filter") <> '' then
                    lPlaningEntryTmp.SetFilter("Resource Group No.", GetFilter("Resource Gr. Filter"));
                if GetFilter("Resource Filter") <> '' then
                    lPlaningEntryTmp.SetFilter("No.", GetFilter("Resource Filter"));

                lPlaningEntryTmp.SetFilter(Status, '<>%1', lPlaningEntryTmp.Status::Deleted);
                // lForm.GetRecord(lPlaningEntryTmp);
                // lForm.SetTableview(lPlaningEntryTmp);
                // lForm.SetOnOpenForm();
                // lForm.SetShowHistory(false);

                // if lFORM.RunModal = Action::LookupOK then;
            end;
        }

    }
    keys
    {
        /*GL2024
                key(STG_Key5; Status, "Person Responsible", "No.")
                {
                }
                key(STG_Key6; "Person Responsible", "No.", Status)
                {
                }
                key(STG_Key7; Status, "Global Dimension 1 Code", "Global Dimension 2 Code", "No.")
                {
                }
                key(STG_Key8; "Global Dimension 1 Code", "Global Dimension 2 Code", "No.", Status)
                {
                }
                key(STG_Key9; Status, "No.")
                {
                }
                key(STG_Key10; Synchronise)
                {
                }*/
    }


    procedure CreateJobDimension(Action_po: Option Insert,Rename,Delete)
    var
        JobSetup: Record "Jobs Setup";
        GeneralSetup: Record "General Ledger Setup";
        DimensionValue_lr: Record "Dimension Value";
        DefaultDimension_lr: Record "Default Dimension";
        Job: Record "Job";
    begin

        // >>> VBS(CDE) Job Dimension
        JobSetup.GET;
        JobSetup.TESTFIELD("Job Dimension Code");
        GeneralSetup.get();
        Job.get(rec."No.");
        CASE Action_po OF
            Action_po::Insert:
                BEGIN
                    IF DimensionValue_lr.GET(JobSetup."Job Dimension Code", Rec."No.") THEN BEGIN
                        DimensionValue_lr.Name := copystr(Job.Description, 1, 50);
                        DimensionValue_lr.MODIFY;
                    END ELSE BEGIN
                        DimensionValue_lr.RESET;
                        DimensionValue_lr."Dimension Code" := JobSetup."Job Dimension Code";
                        DimensionValue_lr.Code := rec."No.";
                        DimensionValue_lr.Name := copystr(Job.Description, 1, 50);
                        DimensionValue_lr."Global Dimension No." := 0;
                        GeneralSetup.GET;
                        IF GeneralSetup."Global Dimension 1 Code" = JobSetup."Job Dimension Code" THEN
                            DimensionValue_lr."Global Dimension No." := 1;
                        IF GeneralSetup."Global Dimension 2 Code" = JobSetup."Job Dimension Code" THEN
                            DimensionValue_lr."Global Dimension No." := 2;

                        DimensionValue_lr.INSERT;
                        IF GeneralSetup."Global Dimension 1 Code" = JobSetup."Job Dimension Code" THEN
                            "Global Dimension 1 Code" := rec."No.";
                        IF GeneralSetup."Global Dimension 2 Code" = JobSetup."Job Dimension Code" THEN
                            "Global Dimension 2 Code" := rec."No.";

                    END;
                    IF NOT DefaultDimension_lr.GET(167, rec."No.", JobSetup."Job Dimension Code") THEN BEGIN
                        DefaultDimension_lr.RESET;
                        DefaultDimension_lr."Table ID" := 167;
                        DefaultDimension_lr."No." := rec."No.";
                        DefaultDimension_lr."Dimension Code" := JobSetup."Job Dimension Code";
                        DefaultDimension_lr."Dimension Value Code" := Rec."No.";
                        DefaultDimension_lr.INSERT;
                    END;
                END;
            Action_po::Rename:
                BEGIN
                    IF DimensionValue_lr.GET(JobSetup."Job Dimension Code", xRec."No.") THEN BEGIN
                        DimensionValue_lr.DELETE;
                        DimensionValue_lr."Dimension Code" := JobSetup."Job Dimension Code";
                        DimensionValue_lr.Code := rec."No.";
                        DimensionValue_lr.Name := copystr(Job.Description, 1, 50);
                        DimensionValue_lr.INSERT;
                        DefaultDimension_lr.SETRANGE("Table ID", 167);
                        DefaultDimension_lr.SETRANGE("No.", rec."No.");
                        DefaultDimension_lr.DELETEALL;
                        DefaultDimension_lr."Table ID" := 167;
                        DefaultDimension_lr."No." := rec."No.";
                        DefaultDimension_lr."Dimension Code" := JobSetup."Job Dimension Code";
                        DefaultDimension_lr."Dimension Value Code" := rec."No.";
                        DefaultDimension_lr.INSERT;
                        IF GeneralSetup."Global Dimension 1 Code" = JobSetup."Job Dimension Code" THEN
                            VALIDATE("Global Dimension 1 Code", rec."No.");
                        IF GeneralSetup."Global Dimension 2 Code" = JobSetup."Job Dimension Code" THEN
                            VALIDATE("Global Dimension 2 Code", rec."No.");

                    END;
                END;
            Action_po::Delete:
                BEGIN
                    IF GeneralSetup."Global Dimension 1 Code" = JobSetup."Job Dimension Code" THEN
                        VALIDATE("Global Dimension 1 Code", '');
                    IF GeneralSetup."Global Dimension 2 Code" = JobSetup."Job Dimension Code" THEN
                        VALIDATE("Global Dimension 2 Code", '');
                    IF DimensionValue_lr.GET(JobSetup."Job Dimension Code", rec."No.") THEN
                        DimensionValue_lr.DELETE(TRUE);
                    DefaultDimension_lr.SETRANGE("Table ID", 167);
                    DefaultDimension_lr.SETRANGE("No.", rec."No.");
                    DefaultDimension_lr.DELETEALL;
                END;
        END;
    end;

    procedure GetDimensionSetId() DimSetId: Integer
    var
        DimensionSetId: Record "Dimension Set Entry" temporary;
        DefDim: Record "Default Dimension";
        GeneralSetup: Record "General Ledger Setup";
    begin
        GeneralSetup.get();
        if GeneralSetup."Shortcut Dimension 1 Code" <> '' then begin
            DimensionSetId."Dimension Set ID" := -1;
            DimensionSetId."Dimension Code" := GeneralSetup."Shortcut Dimension 1 Code";
            DimensionSetId."Dimension Value Code" := Rec."Global Dimension 1 Code";
            DimensionSetId.INSERT(TRUE);
        end;
        if GeneralSetup."Shortcut Dimension 2 Code" <> '' then begin
            DimensionSetId."Dimension Set ID" := -1;
            DimensionSetId."Dimension Code" := GeneralSetup."Shortcut Dimension 2 Code";
            DimensionSetId."Dimension Value Code" := Rec."Global Dimension 2 Code";
            DimensionSetId.INSERT(TRUE);
        end;

        if GeneralSetup."Shortcut Dimension 3 Code" <> '' then begin
            DimensionSetId."Dimension Set ID" := -1;
            DimensionSetId."Dimension Code" := GeneralSetup."Shortcut Dimension 3 Code";
            DimensionSetId."Dimension Value Code" := Rec."Short Dimension 3 Code";
            DimensionSetId.INSERT(TRUE);
        end;
        if GeneralSetup."Shortcut Dimension 4 Code" <> '' then begin
            DimensionSetId."Dimension Set ID" := -1;
            DimensionSetId."Dimension Code" := GeneralSetup."Shortcut Dimension 4 Code";
            DimensionSetId."Dimension Value Code" := Rec."Short Dimension 4 Code";
            DimensionSetId.INSERT(TRUE);
        end;
        if GeneralSetup."Shortcut Dimension 5 Code" <> '' then begin
            DimensionSetId."Dimension Set ID" := -1;
            DimensionSetId."Dimension Code" := GeneralSetup."Shortcut Dimension 5 Code";
            DimensionSetId."Dimension Value Code" := Rec."Short Dimension 5 Code";
            DimensionSetId.INSERT(TRUE);
        end;
        if GeneralSetup."Shortcut Dimension 6 Code" <> '' then begin
            DimensionSetId."Dimension Set ID" := -1;
            DimensionSetId."Dimension Code" := GeneralSetup."Shortcut Dimension 6 Code";
            DimensionSetId."Dimension Value Code" := Rec."Short Dimension 6 Code";
            DimensionSetId.INSERT(TRUE);
        end;
        if GeneralSetup."Shortcut Dimension 7 Code" <> '' then begin
            DimensionSetId."Dimension Set ID" := -1;
            DimensionSetId."Dimension Code" := GeneralSetup."Shortcut Dimension 7 Code";
            DimensionSetId."Dimension Value Code" := Rec."Short Dimension 7 Code";
            DimensionSetId.INSERT(TRUE);
        end;
        if GeneralSetup."Shortcut Dimension 8 Code" <> '' then begin
            DimensionSetId."Dimension Set ID" := -1;
            DimensionSetId."Dimension Code" := GeneralSetup."Shortcut Dimension 8 Code";
            DimensionSetId."Dimension Value Code" := Rec."Short Dimension 8 Code";
            DimensionSetId.INSERT(TRUE);
        end;
        DimSetId := DimensionSetId.GetDimensionSetID(DimensionSetId);
    end;

    procedure CreateLocationAndBin()
    var
        RecLLocation: Record Location;
        RecLBin: Record Bin;
        RecLLocation2: Record Location;
        RecLJobSetup: Record "Jobs Setup";
        RecLDefaultDim: Record "Default Dimension";
        TxtLLocationCreation: Label 'Job location and Bin were not created, please you have to create it manualy.';
    begin
        RecLJobSetup.Get();
        IF StrLen(rec."No.") <= 10 then begin
            RecLLocation.Init();
            RecLLocation.code := rec."No.";
            RecLLocation.Name := rec.Description;
            RecLLocation."Name 2" := rec."Description 2";
            RecLLocation."Project Location" := true;
            IF NOT RecLLocation.Insert() then begin

                Rec."Affectation Magasin" := RecLLocation.code;
                RecLLocation.Modify();
            end;
            IF RecLJobSetup."Job Dimension Code" <> '' then begin
                RecLDefaultDim.Init();
                RecLDefaultDim.Validate("Table ID", Database::Location);
                RecLDefaultDim.Validate("No.", rec."No.");
                RecLDefaultDim.Validate("Dimension Code", RecLJobSetup."Job Dimension Code");
                RecLDefaultDim.Validate("Dimension Value Code", rec."No.");
                IF NOT RecLDefaultDim.Insert() then
                    RecLDefaultDim.Modify();
            end;
            /*HS    RecLLocation2.SetRange("Central location", true);
                IF RecLLocation2.FindFirst() then begin
                    RecLBin.Init();
                    RecLBin."Location Code" := RecLLocation2.Code;
                    RecLBin.Code := rec."No.";
                    RecLBin.Description := rec.Description;
                    IF NOT RecLBin.Insert() then
                        RecLBin.Modify();
                end;HS*/

        end
        else
            Message(TxtLLocationCreation);
    end;

    procedure wGetCaptionNaviBat(pFieldNumber: Integer): Text[250]
    var
        lNaviBatSetup: Record NavibatSetup;
        lReturnText: Text[250];
    begin
        with lNaviBatSetup do begin
            GET2;
            case pFieldNumber of
                20:
                    exit(wNaviBatCaption("Person Responsible Name 1", Rec.FieldCaption("Person Responsible")));
                8003947:
                    exit(wNaviBatCaption("Person Responsible Name 2", Rec.FieldCaption("Person Responsible 2")));
                8003948:
                    exit(wNaviBatCaption("Person Responsible Name 3", Rec.FieldCaption("Person Responsible 3")));
                8003949:
                    exit(wNaviBatCaption("Person Responsible Name 4", Rec.FieldCaption("Person Responsible 4")));
                8003950:
                    exit(wNaviBatCaption("Person Responsible Name 5", Rec.FieldCaption("Person Responsible 5")));
                8003951:
                    exit(wNaviBatCaption("Free Text Name 1", Rec.FieldCaption("Free Text 1")));
                8003952:
                    exit(wNaviBatCaption("Free Text Name 2", Rec.FieldCaption("Free Text 2")));
                8003953:
                    exit(wNaviBatCaption("Free Text Name 3", Rec.FieldCaption("Free Text 3")));
                8003954:
                    exit(wNaviBatCaption("Free Text Name 4", Rec.FieldCaption("Free Text 4")));
                8003955:
                    exit(wNaviBatCaption("Free Text Name 5", Rec.FieldCaption("Free Text 5")));
                8003966:
                    exit(wNaviBatCaption("Free Date Name 1", Rec.FieldCaption("Free Date 1")));
                8003967:
                    exit(wNaviBatCaption("Free Date Name 2", Rec.FieldCaption("Free Date 2")));
                8003968:
                    exit(wNaviBatCaption("Free Date Name 3", Rec.FieldCaption("Free Date 3")));
                8003969:
                    exit(wNaviBatCaption("Free Date Name 4", Rec.FieldCaption("Free Date 4")));
                8003970:
                    exit(wNaviBatCaption("Free Date Name 5", Rec.FieldCaption("Free Date 5")));
                8003971:
                    exit(wNaviBatCaption("Free Date Name 6", Rec.FieldCaption("Free Date 6")));
                8003972:
                    exit(wNaviBatCaption("Free Date Name 7", Rec.FieldCaption("Free Date 7")));
                8003973:
                    exit(wNaviBatCaption("Free Date Name 8", Rec.FieldCaption("Free Date 8")));
                8003974:
                    exit(wNaviBatCaption("Free Date Name 9", Rec.FieldCaption("Free Date 9")));
                8003975:
                    exit(wNaviBatCaption("Free Date Name 10", Rec.FieldCaption("Free Date 10")));
                8003976:
                    exit(wNaviBatCaption("Free Value Name 1", Rec.FieldCaption("Free Value 1")));
                8003977:
                    exit(wNaviBatCaption("Free Value Name 2", Rec.FieldCaption("Free Value 2")));
                8003978:
                    exit(wNaviBatCaption("Free Value Name 3", Rec.FieldCaption("Free Value 3")));
                8003979:
                    exit(wNaviBatCaption("Free Value Name 4", Rec.FieldCaption("Free Value 4")));
                8003980:
                    exit(wNaviBatCaption("Free Value Name 5", Rec.FieldCaption("Free Value 5")));
                8003981:
                    exit(wNaviBatCaption("Free Boolean Name 1", Rec.FieldCaption("Free Boolean 1")));
                8003982:
                    exit(wNaviBatCaption("Free Boolean Name 2", Rec.FieldCaption("Free Boolean 2")));
                8003983:
                    exit(wNaviBatCaption("Free Boolean Name 3", Rec.FieldCaption("Free Boolean 3")));
                8003984:
                    exit(wNaviBatCaption("Free Boolean Name 4", Rec.FieldCaption("Free Boolean 4")));
                8003985:
                    exit(wNaviBatCaption("Free Boolean Name 5", Rec.FieldCaption("Free Boolean 5")));
            end;
        end;
    end;


    procedure wNaviBatCaption(pNaviBat: Text[30]; pCaption: Text[30]): Text[50]
    begin
        if pNaviBat <> '' then
            exit('1,5,,' + pNaviBat)
        else
            exit('1,5,,' + pCaption);
    end;


    procedure wSynchro(pCurrFieldNo: Integer; pName: Text[50])
    var
        lSalesDoc: Record "Sales Header";
        lRecRefSales: RecordRef;
        lFieldRefSales: FieldRef;
        lFieldRefSalesNo: FieldRef;
        lRecRefJob: RecordRef;
        lFieldRefJob: FieldRef;
        lFieldRefJobNo: FieldRef;
        lCurrFieldNoSales: Integer;
        lValue: Text[50];
        lOKAllSalesDoc: Boolean;
    begin
        case pCurrFieldNo of
            20:
                lCurrFieldNoSales := 8003912;
            13:
                lCurrFieldNoSales := 8003988;
            14:
                lCurrFieldNoSales := 8003989;
            FieldNo("Salesperson Code"):
                lCurrFieldNoSales := 43;
            else
                lCurrFieldNoSales := pCurrFieldNo;
        end;
        lRecRefJob.GetTable(Rec);
        lFieldRefJob := lRecRefJob.Field(pCurrFieldNo);
        lSalesDoc.SetCurrentkey("Job No.");
        lSalesDoc.SetRange("Job No.", "No.");
        if not lSalesDoc.IsEmpty then begin
            lSalesDoc.Find('-');
            lRecRefSales.GetTable(lSalesDoc);
            lFieldRefSales := lRecRefSales.Field(lCurrFieldNoSales);

            if not (StrSubstNo('%1', lFieldRefJob.Value) in ['', '0']) and
               (lFieldRefSales.Value <> lFieldRefJob.Value) then
                if lSalesDoc.Count > 1 then
                    lOKAllSalesDoc := Confirm(TextSynchro, true, pName,
                           lFieldRefSales.Value, lFieldRefJob.Value, tAllDoc, lSalesDoc."Job No.");
            repeat
                lRecRefSales.GetTable(lSalesDoc);
                lFieldRefSales := lRecRefSales.Field(lCurrFieldNoSales);
                lFieldRefSalesNo := lRecRefSales.Field(3);
                if (StrSubstNo('%1', lFieldRefSales.Value) in ['', '0']) then
                    //#5216
                    //      IF (lFieldRefSales.VALUE <> lFieldRefJob.VALUE) THEN BEGIN
                    if (lFieldRefSales.Value <> lFieldRefJob.Value) and (Format(lFieldRefJob) <> '') then begin
                        //#5216//
                        if not lOKAllSalesDoc then begin
                            if Confirm(TextSynchro, true, pName, lFieldRefSales.Value, lFieldRefJob.Value,
                                       lSalesDoc."Document Type", lSalesDoc."No.") then begin
                                lFieldRefSales.Value(lFieldRefJob.Value);
                                lRecRefSales.Modify;
                            end;
                        end else begin
                            lFieldRefSales.Value := lFieldRefJob.Value;
                            lRecRefSales.Modify;
                        end;
                    end;
            until lSalesDoc.Next = 0;
        end;
    end;


    procedure wCheckBlockedJob(var pJobNo: Code[20])
    var
        lJob: Record Job;



    begin
        //PROJET
        if pJobNo = '' then
            exit;
        lJob.Get(pJobNo);
        with lJob do begin
            //#5458  TESTFIELD(Status,Status::Order);
            //  TESTFIELD(Blocked,FALSE);
            TestField(Blocked, Blocked::" ");
            TestField(Finished, false);
        end;
        //PROJET//
    end;


    procedure wEntryExists(): Boolean
    var
        lJobLedgerEntry: Record "Job Ledger Entry";
        lSalesLine: Record "Sales Line";
        lPurchaseLine: Record "Purchase Line";
    begin
        lJobLedgerEntry.SetCurrentkey("Job No.");
        lJobLedgerEntry.SetRange("Job No.", "No.");
        if not lJobLedgerEntry.IsEmpty then
            exit(true);
        lSalesLine.SetCurrentkey("Job No.", "Document Type", "Document No.");
        lSalesLine.SetRange("Job No.", "No.");
        if not lSalesLine.IsEmpty then
            exit(true);
        lPurchaseLine.SetCurrentkey("Job No.");
        lPurchaseLine.SetRange("Job No.", "No.");
        if not lPurchaseLine.IsEmpty then
            exit(true);
    end;

    trigger OnInsert()
    begin
        Rec.Status := Rec.Status::Planning;
    end;

    procedure wGetTotalingChar(): Code[1]
    var
        lNavibatSetup: Record NavibatSetup;
    begin
        if lNavibatSetup.GET2 then
            exit(lNavibatSetup."Totalisation Character");
    end;


    procedure gGetDefaultJobTask(): Code[20]
    var
        lJobTask: Record "Job Task";
        ltNoOpenTask: label 'L''affaire %1 ne comporte aucune tâche imputable..';
    begin
        lJobTask.Reset();
        lJobTask.SetRange("Job No.", rec."No.");
        lJobTask.SetRange("Job Task Type", lJobTask."job task type"::Posting);
        //#5330
        //IF ISEMPTY THEN
        //   EXIT('');
        lJobTask.SetRange(Blocked, false);
        if lJobTask.IsEmpty then
            Error(ltNoOpenTask, "No.");
        //#5330//
        if lJobTask.Count = 1 then begin
            lJobTask.FindFirst;
            exit(lJobTask."Job Task No.")
        end;
        //#5330
        /*
        lJobTask.SETRANGE("Default Job Task",TRUE);
        IF lJobTask.FINDFIRST THEN
          EXIT(lJobTask."Job Task No.")
        ELSE
          EXIT('');
        */
        //#5330//

    end;


    procedure gInsertDefaultJobTask()
    var
        lNaviBatSetup: Record NavibatSetup;
        lRecordRef: RecordRef;
        lTemplateMgt: Codeunit "Config. Template Management";
        CduFunction: Codeunit SoroubatFucntion;
        lJobTask: Record "Job Task";
    begin
        //+ONE+JOB_TASK
        if lNaviBatSetup.Get and (lNaviBatSetup."Job Task Creation Model" <> '') then begin
            lRecordRef.Open(Database::"Job Task");
            CduFunction.SetValue(lRecordRef, lNaviBatSetup."Job Task Creation Model");
            lRecordRef.SetTable(lJobTask);
            lJobTask."Job No." := "No.";
            lJobTask.Insert;
        end;
        //+ONE+JOB_TASK//
    end;


    procedure lSetJobTotalingLevel(var pRec: Record Job)
    var
        t8003900: label 'You can''t use the ''.'' character on the last opsition of Field "%1"';
        i: Integer;
        AA: record "Value Entry";
    begin
        ///Summary
        // @Input@ : Job Table
        // @OUtput@ : Void
        // @Description@ = This function update the Field "level" depending on the Job "No."
        ///Summary//

        pRec.Level := 0;
        for i := 1 to StrLen(pRec."No.") do
            if pRec."No."[i] in ['.', ' '] then begin
                if (pRec."No."[i] = '.') and (i = StrLen(pRec."No.")) then
                    Error(t8003900, pRec.FieldCaption("No."));
                pRec.Level += 1;
            end;
    end;


    procedure lSetJobTotalingField(var pRec: Record Job)
    begin
        ///Summary
        // @Input@ : Job Table
        // @OUtput@ : Void
        // @Description@ = This function update the Field "Job Totaling" with the Job "No."
        ///Summary//

        if not pRec.Summarize then
            pRec."Job Totaling" := pRec."No."
        else
            pRec."Job Totaling" := pRec."No." + '..' + pRec."No." + '.' + wGetTotalingChar;
    end;


    trigger OnBeforeInsert()
    var
        lRespCenter: Record 5714;
    begin
        //AGENCE
        IF (gUserMgt.GetSalesFilter() = '') AND lRespCenter.READPERMISSION AND lRespCenter.FIND('-') AND
           ("Responsibility Center" = '') THEN BEGIN
            COMMIT;
            IF Page.RUNMODAL(0, lRespCenter) = ACTION::LookupOK THEN
                "Responsibility Center" := lRespCenter.Code;
        END;
        //AGENCE//

    end;


    var

        wPostCode: Record "Post Code";
        wJobProgress: Record "Document Progress Degree";
        Text1100280003: label 'If you modify %1, you will modify %1 on %2.\Do ypu want to continue ?';
        Text1100280004: label '%1 must be less than previous value.';
        Text1100280006: label '%1 must not be %2 in %3 %4.';
        Text1100280008: label 'You must get through step %1.';
        Text8003917: label 'Change the %1 %2?';
        Text8003918: label '%1 %';
        wNavibatSetup: Record NavibatSetup;
        TextSynchro: label 'Do you want to replace %1 %2 by %3 in %4 %5?';
        wStatSetup: Record "Statistics setup";
        tNotEmpty: label 'not editable when entries exists';
        tUndo: label 'Status not updated.';
        tAllDoc: label 'all documents of Job No. ';
        gUserMgt: Codeunit "User Setup Management";
        gNoRespCenterSeriesMgt: Codeunit NoSeriesRespCenterManagement;
        tDimWarning: label 'Warning : existing entries will not be modified.\Do-you want to modify dimension code?';
        gJobLedgEntry: Record "Job Ledger Entry";
        tExistEntry: label 'You cannot delete %1 %2 because there is at least one %3 that includes this job.';
        tStatusIsOrder: label 'You cannot delete %1 %2 because status is Order.';
        wCaptionClassTrans: Record "CaptionClass Translation";
        PostCode: Record "Post Code";
}

