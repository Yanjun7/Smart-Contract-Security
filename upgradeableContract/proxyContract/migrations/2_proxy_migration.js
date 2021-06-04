const Dog = artifacts.require("Dog");
const DogUpgraded = artifacts.require("DogUpgraded");
const Proxy = artifacts.require("Proxy");

module.exports = async function(deployer, network, accounts){
    const dog = await Dog.new();
    const proxy = await Proxy.new(dog.address);

    //the following won't work because truffle can't find setNumberOfDogs() function in the proxy contract
    //await proxy.setNumberOfDogs(10)
    let proxyDog = await Dog.at(proxy.address);
    await proxyDog.setNumberOfDogs(10);
    var numOfDogs = await proxyDog.getNumberOfDogs();
    console.log("Number of dogs in proxy contract storage: "+numOfDogs.toNumber());
    // numOfDogs = await dog.getNumberOfDogs();
    // console.log("Number of dogs in dog contract storage: "+numOfDogs.toNumber());
    //the above code tells truffle to create a dog instance from an existing instance
    //using Dog source code but with proxy address
    //We're fooling truffle that this is a real dog contract while pointing it to the proxy address
    //this works because we know the proxy can handle the function calls that the dog function can handle
    const dogUpgraded = await DogUpgraded.new();
    proxy.upgrade(dogUpgraded.address); // here can't use proxyDog because truffle thinks it's a dog contract instance
    // both proxy and proxyDog are pointing to the same proxy contract instance 
    numOfDogs = await proxyDog.getNumberOfDogs();
    console.log("Number of dogs in proxy contract storage after upgrading: "+numOfDogs.toNumber());

    await proxyDog.setNumberOfDogs(3); 
    // for the current setting this will failed with the setNumberOfDogs() function having a onlyOwner modifier
    // we're using the delegatecall() to redirect requests from proxy to dog, that's why we're using proxy's state not dog's
}