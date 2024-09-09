import React, { useState, useEffect } from 'react';

function App() {
  const [inventoryUpdates, setInventoryUpdates] = useState([]);

  useEffect(() => {
    const ws = new WebSocket('ws://localhost:8080/');
  
    ws.onopen = () => {
      console.log('WebSocket connected');
    };
  
    ws.onmessage = (event) => {
      const data = JSON.parse(event.data);
      console.log('Received update:', data);

      if (data.inventory <= 5) {
        alert(`Inventory low for ${data.store} - ${data.model}: ${data.inventory} pairs left!`);
      }
  
      setInventoryUpdates((prevUpdates) => [data, ...prevUpdates]);
    };
  
    ws.onerror = (error) => {
      console.error('WebSocket error:', error);
    };
  
    ws.onclose = (event) => {
      console.log('WebSocket closed:', event);
    };
  
    return () => {
      ws.close();
    };
  }, []);
  

  return (
    <div className="App">
      <h1>Shoe Store Inventory Updates</h1>
      <ul>
        {inventoryUpdates.map((update, index) => (
          <li key={index}>
            {update.store} store sold a pair of {update.model} shoes. {update.store} now has {update.inventory} pairs of {update.model} left.
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;
