// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library MyStructLibrary {
    struct MyStruct {
        uint256 data;
        
        function setData(MyStruct storage self, uint256 _data) internal {
            self.data = _data;
        }
        
        function getData(MyStruct storage self) internal view returns (uint256) {
            return self.data;
        }
    }
}

contract MyContract {
    using MyStructLibrary for MyStructLibrary.MyStruct;
    MyStructLibrary.MyStruct myStruct;

    function setStructData(uint256 _data) public {
        myStruct.setData(_data);
    }

    function getStructData() public view returns (uint256) {
        return myStruct.getData();
    }
}
