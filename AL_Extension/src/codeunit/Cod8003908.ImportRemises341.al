Codeunit 8003908 "Import Remises 341"
{
    // //IMPORT_CUSTOM CW 21/07/03 Import customize

    TableNo = "Item Discount Group";
    /* GL2024
        trigger OnRun()
        var
            lCatFam: Record 8003928;
        begin
            SingleInstance.Get(ImportLog);

            case SingleInstance.
              ImportLog.PreImport;

              ImportLog.BeforeUpdatebegin
                if lCatFam.Get(CopyStr(Code, 4)) then
                  Description := CopyStr(lCatFam.Description, 1, MaxStrLen(Description))
                else
                    Description := '?';
            end;

            ImportLog.PostImport;

            else
            end;
        end;
    */
    var
        ImportLog: Record "Import Log";
        SingleInstance: Codeunit "Import SingleInstance2";
}

