pragma solidity >=0.4.22 <0.6.0;

contract crud {
    
    //estrutura do usuario
    struct user {
        string email;
        uint idade;
        uint index;
    }
    
    //mapping , dicionario, um conjunto de chave valor onde a estrutura user é o valor chave 
    mapping (address => user) private usuarios;
    address [] private userIndex;
    
    
    //funcao captura o valor recebido em useradress, retornando
    //o valor para o useradress setando o .index recebido no maping usuarios dentro do array userIndex
    function verificaUsuario (address userAddress) public constant returns (bool isIndeed) {
            if (userIndex.length == 0) return false;
            return (userIndex[usuarios[userAddress].index] == userAddress);
    }
           
        
    
    /*funcao recebe os parametros userAddress, email e idade, retornando um index, 
    a funcao usa a funcao verificaUsuario para capturar o userAddress
    depois passa os valores recebidos pela igualdade para cada userAddress.elemento do struct do mapping usuarios
    */
    
    function insereUsuer (address userAddress, string email, uint idade) public returns (uint index) {
            if(verificaUsuario(userAddress)) throw;
            usuarios[userAddress].email = email;
            usuarios[userAddress].idade = idade;
            usuarios[userAddress].index = userIndex.push(userAddress) -1;
        return userIndex.length -1; //retorna um index
    } 
    
    //funcao retorna o tamanho do array
    function verUser () public view returns (uint) {
        return userIndex.length;
    }
    
    function verUsuarios(uint index) public constant returns (address userAddress) {
        return userIndex[index];
    }
    
    function pegaUser (address userAddress) public constant returns (
        string email,
        uint idade,
        uint index
        ) {
            if(!verificaUsuario(userAddress)) throw;
            return (
                usuarios[userAddress].email,
                usuarios[userAddress].idade,
                usuarios[userAddress].index
                );
        
    }
    
    
    function alteraEmail (address userAddress, string email) public returns (bool sucesso) {
        if(!verificaUsuario(userAddress)) throw;
        usuarios[userAddress].email = email;
        return true;
    }
    function alteraIdade (address userAddress, uint idade) public returns (bool sucesso) {
        if(!verificaUsuario(userAddress)) throw;
        usuarios[userAddress].idade = idade;
        return true;
    }
    function deleteUser (address userAddress) public returns (bool sucesso) {
        if(!verificaUsuario(userAddress)) throw;
        delete usuarios[userAddress].email;
        delete usuarios[userAddress].idade;
        delete usuarios[userAddress].index;
        return true;
        
    }
    
}
