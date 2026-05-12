Table 8003900 NavibatSetup
{
    // //GL2024 PROTECTED

    Caption = 'NaviBat Setup';
    // LookupPageID = 8003909;
    Permissions = TableData NavibatSetup = rimd;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(8003902; "Post Balance Job Entry"; Boolean)
        {
            Caption = 'Post Balance Job Entry';
        }
        field(8003903; "Post Job Entry"; Boolean)
        {
            Caption = 'Post Job Entry from G/L Acc.';

            trigger OnValidate()
            var
                TextModif: label 'Changing this field will cause the program to modify the G/L Accounts.\';
                TextConfirm: label 'Do you want to change this field?';
                lGLAcc: Record "G/L Account";
            begin
                //GL2024   //GL2024 PROTECTED
            end;
        }
        field(8003904; "Job Control Obligatory"; Option)
        {
            Caption = 'Job Control Obligatory';
            OptionCaption = ' ,Invoice and Cr.Memo,All';
            OptionMembers = " ","Invoice and Cr.Memo",All;
        }
        field(8003905; "Appln. between Job"; Option)
        {
            Caption = 'Appln. between Job';
            OptionCaption = 'None,Same Job';
            OptionMembers = "None","Same Job";
        }
        field(8003906; "Overhead Value Option"; Option)
        {
            Caption = 'Overhead Value Option';
            OptionCaption = '% on Base,% on Result,Coefficient';
            OptionMembers = "% on Base","% on Result",Coefficient;
        }
        field(8003907; "Margin Value Option"; Option)
        {
            Caption = 'Margin Value Option';
            OptionCaption = '% on Base %,% on Result,Coefficient';
            OptionMembers = "% on Base %","% on Result",Coefficient;
        }
        field(8003908; "Quantity Base calculate"; Boolean)
        {
            Caption = 'Quantity Base calculate';
        }
        field(8003909; "Ignore Job Cost Around"; Boolean)
        {
            Caption = 'Ignore Job Cost Around';
        }
        field(8003910; "Margin Rate Calculation"; Option)
        {
            Caption = 'Margin Rate Calculation';
            OptionCaption = 'distributed,Not distribute';
            OptionMembers = distributed,"Not distribute";
        }
        field(8003914; "Interim Mission Nos"; Code[10])
        {
            Caption = 'Interim Mission Nos';
            TableRelation = "No. Series";
        }
        field(8003915; "Person Responsible Name 1"; Text[30])
        {
            Caption = 'Person Responsible Name 1';
        }
        field(8003916; "Person Responsible Name 2"; Text[30])
        {
            Caption = 'Person Responsible Name 2';
        }
        field(8003917; "Person Responsible Name 3"; Text[30])
        {
            Caption = 'Person Responsible Name 3';
        }
        field(8003918; "Person Responsible Name 4"; Text[30])
        {
            Caption = 'Person Responsible Name 4';
        }
        field(8003919; "Person Responsible Name 5"; Text[30])
        {
            Caption = 'Person Responsible Name 5';
        }
        field(8003920; "Free Text Name 1"; Text[30])
        {
            Caption = 'Free Text Name 1';
        }
        field(8003921; "Free Text Name 2"; Text[30])
        {
            Caption = 'Free Text Name 2';
        }
        field(8003922; "Free Text Name 3"; Text[30])
        {
            Caption = 'Free Text Name 3';
        }
        field(8003923; "Free Text Name 4"; Text[30])
        {
            Caption = 'Free Text Name 4';
        }
        field(8003924; "Free Text Name 5"; Text[30])
        {
            Caption = 'Free Text Name 5';
        }
        field(8003935; "Free Date Name 1"; Text[30])
        {
            Caption = 'Free date name 1';
        }
        field(8003936; "Free Date Name 2"; Text[30])
        {
            Caption = 'Free date name 2';
        }
        field(8003937; "Free Date Name 3"; Text[30])
        {
            Caption = 'Free date name 3';
        }
        field(8003938; "Free Date Name 4"; Text[30])
        {
            Caption = 'Free date name 4';
        }
        field(8003939; "Free Date Name 5"; Text[30])
        {
            Caption = 'Free date name 5';
        }
        field(8003940; "Free Date Name 6"; Text[25])
        {
            Caption = 'Free date name 6';
        }
        field(8003941; "Free Date Name 7"; Text[25])
        {
            Caption = 'Free date name 7';
        }
        field(8003942; "Free Date Name 8"; Text[25])
        {
            Caption = 'Free date name 8';
        }
        field(8003943; "Free Date Name 9"; Text[25])
        {
            Caption = 'Free date name 9';
        }
        field(8003944; "Free Date Name 10"; Text[25])
        {
            Caption = 'Free date name 10';
        }
        field(8003945; "Free Value Name 1"; Text[30])
        {
            Caption = 'Free Value Name 1';
        }
        field(8003946; "Free Value Name 2"; Text[30])
        {
            Caption = 'Free Value Name 2';
        }
        field(8003947; "Free Value Name 3"; Text[30])
        {
            Caption = 'Free Value Name 3';
        }
        field(8003948; "Free Value Name 4"; Text[30])
        {
            Caption = 'Free Value Name 4';
        }
        field(8003949; "Free Value Name 5"; Text[30])
        {
            Caption = 'Free Value Name 5';
        }
        field(8003950; "Free Boolean Name 1"; Text[30])
        {
            Caption = 'Free Boolean Name 1';
        }
        field(8003951; "Free Boolean Name 2"; Text[30])
        {
            Caption = 'Free Boolean Name 2';
        }
        field(8003952; "Free Boolean Name 3"; Text[30])
        {
            Caption = 'Free Boolean Name 3';
        }
        field(8003953; "Free Boolean Name 4"; Text[30])
        {
            Caption = 'Free Boolean Name 4';
        }
        field(8003954; "Free Boolean Name 5"; Text[30])
        {
            Caption = 'Free Boolean Name 5';
        }
        field(8003956; "Disable Copy Dim to Quote"; Boolean)
        {
            Caption = 'Disable Copy Dim to Quote';
        }
        field(8003957; "Line Committed"; Boolean)
        {
            Caption = 'Line Committed';
            InitValue = false;
        }
        field(8003958; "WT Default Qty"; Decimal)
        {
            //blankzero = true;
            Caption = 'Sugg. Work Activity Qty';
        }
        field(8003959; "Profit Calculation Method"; Option)
        {
            Caption = 'Profit/Sales Doc.';
            OptionCaption = 'Structure,Structure line';
            OptionMembers = Structure,"Structure line";
        }
        field(8003960; "Reord. Req. Default Dim."; Option)
        {
            Caption = 'Axe par défaut dde d''appro.';
            OptionCaption = 'of Structure,of Component';
            OptionMembers = Structure,Component;
        }
        field(8003962; "Update Budget in Quotes"; Boolean)
        {
            Caption = 'Create Budget from Quote';
        }
        field(8003963; "Update Budget in Orders"; Boolean)
        {
            Caption = 'Create Budget from Order';
        }
        field(8003964; "Check Resource Cost"; Boolean)
        {
            Caption = 'Check Resource Cost';
        }
        field(8003966; "Export Tracking Job Folder"; Text[250])
        {
            Caption = 'Export Tracking Job Folder';
        }
        field(8003968; "Archive Quote"; Boolean)
        {
            Caption = 'Archive Quote --> Order';
        }
        field(8003969; "Budget on rider"; Option)
        {
            Caption = 'Rider Budget';
            OptionCaption = 'Initial,Audit';
            OptionMembers = Initial,Audit;
        }
        field(8003972; "Tot. Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Totalisation Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(8003973; "Totalisation Character"; Code[1])
        {
            Caption = 'Total Character';

            trigger OnValidate()
            var
                lGenProdPostingGp: Record "Gen. Product Posting Group";
            begin
                //GL2024  //GL2024 PROTECTED
            end;
        }
        field(8003975; "History Purchase Price"; DateFormula)
        {
            Caption = 'History Purchase Price';
        }
        field(8003976; "Project Manager Std Text"; Code[10])
        {
            Caption = 'Text on Proj. Manager Copy';
            TableRelation = "Standard Text";

            trigger OnLookup()
            var
                lLongText: Record "Standard Text";
            begin
                //GL2024  //GL2024 PROTECTED
            end;
        }
        field(8003977; "Sales Document Description"; Text[50])
        {
            Caption = 'Sales Doc. Description';
        }
        field(8003978; "Purchase Document Description"; Text[100])
        {
            Caption = 'Purchase Doc. Description';
        }
        field(8003979; "Supply Order Nos."; Code[10])
        {
            Caption = 'Supply Order Nos.';
            TableRelation = "No. Series";
        }
        field(8003981; "Job Journal Line Res. Descr."; Text[50])
        {
            Caption = 'Job Journal Line Res. Descr.';
        }
        field(8003982; "Job Journal Line Item Descr."; Text[50])
        {
            Caption = 'Job Journal Line Item Descr.';
        }
        field(8003983; "Job Journal Line G/L Descr."; Text[50])
        {
            Caption = 'Job Journal Line G/L Descr.';
        }
        field(8003990; "Free Field 1 Option"; Option)
        {
            Caption = 'Free Field 1 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8003991; "Free Field 2 Option"; Option)
        {
            Caption = 'Free Field 2 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8003992; "Free Field 3 Option"; Option)
        {
            Caption = 'Free Field 3 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8003993; "Free Field 4 Option"; Option)
        {
            Caption = 'Free Field 4 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8003994; "Free Field 5 Option"; Option)
        {
            Caption = 'Free Field 5 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8003995; "Free Field 6 Option"; Option)
        {
            Caption = 'Free Field 6 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8003996; "Free Field 7 Option"; Option)
        {
            Caption = 'Free Field 7 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8003997; "Free Field 8 Option"; Option)
        {
            Caption = 'Free Field 8 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8003998; "Free Field 9 Option"; Option)
        {
            Caption = 'Free Field 9 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8003999; "Free Field 10 Option"; Option)
        {
            Caption = 'Free Field 10 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8004000; "Free Date 1 Option"; Option)
        {
            Caption = 'Free Date 1 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8004001; "Free Date 2 Option"; Option)
        {
            Caption = 'Free Date 2 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8004002; "Free Date 3 Option"; Option)
        {
            Caption = 'Free Date 3 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8004003; "Free Date 4 Option"; Option)
        {
            Caption = 'Free Date 4 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8004004; "Free Date 5 Option"; Option)
        {
            Caption = 'Free Date 5 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8004005; "Free Date 6 Option"; Option)
        {
            Caption = 'Free Date 6 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8004006; "Free Date 7 Option"; Option)
        {
            Caption = 'Free Date 7 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8004007; "Free Date 8 Option"; Option)
        {
            Caption = 'Free Date 8 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8004008; "Free Date 9 Option"; Option)
        {
            Caption = 'Free Date 9 Option';
            OptionCaption = 'Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8004009; "Free Date 10 Option"; Option)
        {
            Caption = 'Free Date 10 Option';
            OptionCaption = 'Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8004010; "Free Value 1 Option"; Option)
        {
            Caption = 'Free Value 1 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8004011; "Free Value 2 Option"; Option)
        {
            Caption = 'Free Value 2 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8004012; "Free Value 3 Option"; Option)
        {
            Caption = 'Free Value 3 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8004013; "Free Value 4 Option"; Option)
        {
            Caption = 'Free Value 4 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8004014; "Free Value 5 Option"; Option)
        {
            Caption = 'Free Value 5 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8004015; "Free Boolean 1 Option"; Option)
        {
            Caption = 'Free Boolean 1 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8004016; "Free Boolean 2 Option"; Option)
        {
            Caption = 'Free Boolean 2 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8004017; "Free Boolean 3 Option"; Option)
        {
            Caption = 'Free Boolean 3 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8004018; "Free Boolean 4 Option"; Option)
        {
            Caption = 'Free Boolean 4 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8004019; "Free Boolean 5 Option"; Option)
        {
            Caption = 'Free Boolean 5 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8004020; "Person Resp. 1 Option"; Option)
        {
            Caption = 'Person Resp. 1 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8004021; "Person Resp. 2 Option"; Option)
        {
            Caption = 'Person Resp. 2 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8004022; "Person Resp. 3 Option"; Option)
        {
            Caption = 'Person Resp. 3 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8004023; "Person Resp. 4 Option"; Option)
        {
            Caption = 'Person Resp. 4 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8004024; "Person Resp. 5 Option"; Option)
        {
            Caption = 'Person Resp. 5 Option';
            OptionCaption = 'Joint,Sales Document,Job';
            OptionMembers = Joint,"Sales Document",Job;

            trigger OnValidate()
            begin
                //GL2024 PROTECTED
            end;
        }
        field(8004025; "Print Shipment with Invoice"; Boolean)
        {
            Caption = 'Print Shipment with Invoice';
        }
        field(8004026; "Close Job with Sales Doc."; Boolean)
        {
            Caption = 'Close Job with Sales Doc.';
        }
        field(8004029; "Transfer Quote Nos."; Code[10])
        {
            Caption = 'Transfer Quote Nos.';
            TableRelation = "No. Series";
        }
        field(8004030; "Transfer Order Nos."; Code[10])
        {
            Caption = 'Transfer Order Nos.';
            TableRelation = "No. Series";
        }
        field(8004031; "Transfer Job Creation Model"; Code[10])
        {
            Caption = 'Transfer Job Creation Model';
            TableRelation = "Config. Template Header".Code where("Table ID" = const(8004160));
        }
        field(8004032; "Transfer Job Creation"; Option)
        {
            Caption = 'Transfer Job Creation';
            OptionCaption = ' ,Sub-Job,Series Number';
            OptionMembers = " ","Sub-Job","Series Number";
        }
        field(8004033; "Transfer Order View Code"; Code[10])
        {
            Caption = 'Transfer Order View Code';
            TableRelation = "Sales Line View";
        }
        field(8004034; "Default Transfer Job No."; Code[20])
        {
            Caption = 'Default Transfer Job No.';
            TableRelation = Job;
        }
        field(8004035; "Number lines before commit"; Integer)
        {
            Caption = 'Number lines committed';
        }
        field(8004036; "Disable update totaling"; Boolean)
        {
            Caption = 'Disable update totaling';
        }
        field(8004037; "Job Creation Model"; Code[10])
        {
            Caption = 'Job Creation Model';
            TableRelation = "Config. Template Header".Code where("Table ID" = const(8004160));
        }
        field(8004038; "Job Task Creation Model"; Code[10])
        {
            Caption = 'Job Task Creation Model';
            TableRelation = "Config. Template Header".Code where("Table ID" = const(8004170));

        }
        field(8004039; "Specific Struct. Price Calcul"; Boolean)
        {
            Caption = 'Specific Struct. Price Calcul';
        }
        field(8004040; "Disable BOQ Calculation"; Boolean)
        {
            Caption = 'Disable BOQ Calculation';
        }
        field(8004041; "Discount Method Calculation"; Option)
        {
            Caption = 'Discount Method Calculation';
            OptionCaption = 'Line Discount,Invoice Discount';
            OptionMembers = "Line Discount","Invoice Discount";
        }
        field(8004042; "Check Sales Document Price"; Boolean)
        {
            Caption = 'Check Sales Document Price';
            Description = '#8425 ADDFIELD';
            InitValue = false;
        }
    }

    keys
    {
        key(STG_Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    var
    //  lSingleInstance: Codeunit "Import SingleInstance2";
    begin
        //GL2024 PROTECTED
    end;

    var
        TextErrorMargin: label 'Margin based on %1 must be inferior to 100.';
        TextErrorOverhead: label 'Overhead based on %1 must be %2 %3.';
        TextInferior: label 'less than';
        TextDifferent: label 'different from';

    local procedure wCheckGLAcc(AccNo: Code[20])
    var
        GLAcc: Record "G/L Account";
    begin
        //GL2024 PROTECTED
    end;


    procedure wChangeOption()
    var
        lJob: Record Job;
        lSalesDoc: Record "Sales Header";
        lRecordRefParam: RecordRef;
        lRecordRefParamxRec: RecordRef;
        lFieldRefParam: FieldRef;
        lFieldRefParamxRec: FieldRef;
        lFieldRefParamDesc: FieldRef;
        lCurrFieldNo: Integer;
        lCurrFieldNoSales: Integer;
    begin
        //GL2024 PROTECTED
    end;


    procedure OverheadRateOnFormat(var pText: Text[30])
    var
        lValue: Decimal;
        lRateFormat: Text[50];
    begin
        //GL2024 PROTECTED
    end;


    procedure OverheadRatetoString(var pValue: Decimal): Text[30]
    var
        lRateFormat: Text[50];
    begin
        //GL2024 PROTECTED
    end;


    procedure OverheadRateOnValidate(var pValue: Decimal)
    begin
        //GL2024 PROTECTED
    end;


    procedure OverheadRateSourceExpr(var pValue: Decimal): Decimal
    begin
        //GL2024 PROTECTED
    end;


    procedure MarginRateOnFormat(var pText: Text[30])
    var
        lValue: Decimal;
        lRateFormat: Text[50];
    begin
        //GL2024 PROTECTED
    end;


    procedure MarginRateToString(var pValue: Decimal): Text[30]
    var
        lRateFormat: Text[50];
    begin
        //GL2024 PROTECTED
    end;


    procedure MarginRateOnValidate(var pValue: Decimal)
    begin
        //GL2024 PROTECTED
    end;


    procedure MarginRateSourceExpr(var pValue: Decimal): Decimal
    begin
        //GL2024 PROTECTED
    end;


    procedure GET2() Return: Boolean
    var
        lRec: Record NavibatSetup;
        lGranuleID: Code[10];
    //  lSingleInstance: Codeunit "Import SingleInstance2";
    //   lAddOnKey: Record "Add-On Licence";
    // lApplicationManagement: Codeunit ApplicationManagement;
    begin
        //GL2024 PROTECTED
    end;

    local procedure lLicenceCheck()
    var
        lGranuleID: Code[10];
        lAddOnKey: Record "Add-On Licence";
        tLicenceNotEnable: label 'Your license is not enable.\Contact the system manager for more information.';
        tDevelopperLicense: label 'You are using a developper license.\Workdate has been set to %1.';
    //    lCheckLicenseMgt: Codeunit "Check Licence Management";
    begin
        //GL2024 PROTECTED
    end;


    procedure CheckGranuleKey(pGranuleKeyCode: Code[20]; pLicenceID: Code[30]; pGranuleID: Code[20]) Return: Integer
    var
        n: Integer;
        d: Integer;
        lMaxiCode: Integer;
        lMinimum: Integer;
        lExpiration: Integer;
        lExpirationDate: Date;
        tInvalidKey: label 'Invalid key for granule %1';
        lGranuleKey: Integer;
        tCloseToExpiration: label 'Warning :the key of activation of Navibat will have to be renewed before the %1.';
        tOutOfDate: label 'You must renew the key of activation of Navibat.\Contact the system manager for more information.';
    begin
        //GL2024 PROTECTED
    end;

    local procedure Decrypter(c: Integer; d: Integer; n: Integer) Return: Integer
    begin
        //GL2024 PROTECTED
    end;

    local procedure f(pLicenceID: Code[30]; pGranuleID: Code[20]; pModulo: Integer) Return: Integer
    var
        i: Integer;
        wStr: Text[50];
    begin
        //GL2024 PROTECTED
    end;

    local procedure PowerMod(a: Integer; b: Integer; c: Integer) Return: Integer
    var
        i: Integer;
    begin
        //GL2024 PROTECTED
    end;

    local procedure Reverse(Text: Text[30]) Return: Text[30]
    var
        i: Integer;
        l: Integer;
    begin
        //GL2024 PROTECTED
    end;


    procedure Sessions() Return: Integer
    var
        lLicense: Record "License Information";
        lInteger: Integer;
    begin
        //GL2024 PROTECTED
    end;
}

