Codeunit 104002 "Delete Old Objects"
{

    trigger OnRun()
    var
        //GL2024 License  StatusLog: Record "Status Log";
        //GL2024 License "Object": Record "Object";
        //GL2024 License
        "Object": Record AllObj;
    //GL2024 License
    begin
        //GL2024 License  StatusLog.StartDeleteObjectExclTables;
        with object do begin
            SetFilter("Object Type", '%1|%2|%3|%4|%5|%6|%7',
             "Object Type"::page, "Object Type"::Report, /*GL2024 Type::Dataport,*/ "Object Type"::XMLport, "Object Type"::Codeunit, "Object Type"::MenuSuite, "Object Type"::Page);
            DeleteAll;
        end;
        DeleteDiscontinuedTables;
        //GL2024 License   StatusLog.FinishStep;
        Message(TXT_ObjDeleted);
    end;

    var
        TXT_ObjDeleted: label 'All objects except tables have now been deleted.';

    local procedure DeleteDiscontinuedTables()
    begin
        DeleteTable(88);
        DeleteTable(89);
        DeleteTable(234);

        DeleteTable(387);

        DeleteTable(470);
        DeleteTable(471);
        DeleteTable(473);

        DeleteTable(700);
        DeleteTable(701);
        DeleteTable(702);
        DeleteTable(703);
        DeleteTable(704);
        DeleteTable(705);
        DeleteTable(706);
        DeleteTable(707);
        DeleteTable(708);
        DeleteTable(709);
        DeleteTable(710);
        DeleteTable(711);
        DeleteTable(712);
        DeleteTable(713);
        DeleteTable(714);
        DeleteTable(715);
        DeleteTable(716);
        DeleteTable(720);
        DeleteTable(5112);
        DeleteTable(5113);
        DeleteTable(5114);
        DeleteTable(5115);
        DeleteTable(5116);
        DeleteTable(5117);
        DeleteTable(5118);
        DeleteTable(5500);

        DeleteTable(6800);
        DeleteTable(6804);
        DeleteTable(6805);
        DeleteTable(6806);
        DeleteTable(6807);
        DeleteTable(6809);
        DeleteTable(6810);
        DeleteTable(6811);
        DeleteTable(6813);
        DeleteTable(6815);
        DeleteTable(6822);
        DeleteTable(6824);
        DeleteTable(6825);
        DeleteTable(6827);
        DeleteTable(6828);
        DeleteTable(6829);
        DeleteTable(6832);
        DeleteTable(6833);
        DeleteTable(6835);
        DeleteTable(6836);
        DeleteTable(6837);
        DeleteTable(6838);
        DeleteTable(6839);
        DeleteTable(6840);
        DeleteTable(6841);
        DeleteTable(6842);
        DeleteTable(6843);
        DeleteTable(6850);
        DeleteTable(6870);
        DeleteTable(6872);

        DeleteTable(7709);

        DeleteTable(8000);
        DeleteTable(8001);
        DeleteTable(8002);
        DeleteTable(8003);
        DeleteTable(8004);
        DeleteTable(8005);

        DeleteTable(8620);

        DeleteTable(8700);
        DeleteTable(8701);
        DeleteTable(8702);
        DeleteTable(8703);
        DeleteTable(8704);
        DeleteTable(8705);
        DeleteTable(8706);
        DeleteTable(8707);
        DeleteTable(8708);
        DeleteTable(8709);
        DeleteTable(8710);
        DeleteTable(8711);
        DeleteTable(8725);
        DeleteTable(8726);
        DeleteTable(8727);
        DeleteTable(9801);

        DeleteTable(99008500);
        DeleteTable(99008501);
        DeleteTable(99008502);
        DeleteTable(99008503);
        DeleteTable(99008504);
        DeleteTable(99008505);
        DeleteTable(99008506);
        DeleteTable(99008507);
        DeleteTable(99008508);
        DeleteTable(99008509);
        DeleteTable(99008510);
        DeleteTable(99008511);
        DeleteTable(99008512);
        DeleteTable(99008513);
        DeleteTable(99008514);
        DeleteTable(99008515);
        DeleteTable(99008516);
        DeleteTable(99008517);
        DeleteTable(99008518);
        DeleteTable(99008519);
        DeleteTable(99008520);
        DeleteTable(99008521);
        DeleteTable(99008522);
        DeleteTable(99008532);
        DeleteTable(99008533);
        DeleteTable(99008534);
    end;

    local procedure DeleteTable(ObjID: Integer)
    var
        ObjectTranslations: Record "Object Translation";


        //GL2024 License Obj: Record "Object";
        //GL2024 License
        Obj: Record AllObj;
        //GL2024 License

        Permissions: Record Permission;
    begin
        ObjectTranslations.SetRange(ObjectTranslations."Object Type",
        ObjectTranslations."object type"::Table);
        ObjectTranslations.SetRange(ObjectTranslations."Object ID", ObjID);
        ObjectTranslations.DeleteAll;
        with Permissions do begin
            SetFilter("Object Type", '%1|%2', "object type"::Table, "object type"::"Table Data");
            SetRange("Object ID", ObjID);
            DeleteAll;
        end;
        if Obj.Get(Obj."Object Type"::Table, '', ObjID) then
            Obj.Delete;
    end;
}

