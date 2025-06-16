import { values } from "ramda";

//Q1
export function all<T>(promises: Array<Promise<T>>): Promise<Array<T>> {
  return new Promise<T[]>((resolve, reject) => {
    const res: T[] = [];
    let resolvedCounter = 0;

    if (promises.length === 0) {
      // No promises
      resolve([]);
    }

    promises.forEach((promise, idx) => {
      promise
        .then((value) => {
          // When promise is finish, take value and do the following
          res[idx] = value;
          resolvedCounter++;
          if (resolvedCounter === promises.length) {
            resolve(res); // Finish successfully, returning the result
          }
        })
        .catch((err) => {
          reject(err); // Something failed
        });
    });
  });
}

// Q2
export function* Fib1() {
  let fst = 1;
  let sec = 1;
  yield fst;
  yield sec;

  while (true) {
    let next = fst + sec;
    fst = sec;
    sec = next;
    yield next;
  }
}

export function* Fib2() {
  let n = 1;
  let goldenRatio = (1 + Math.sqrt(5)) / 2; // φ
  let conjugate = (1 - Math.sqrt(5)) / 2; // ψ
  while (true) {
    let next = Math.round(
      (Math.pow(goldenRatio, n) - Math.pow(conjugate, n)) / Math.sqrt(5)
    );
    n++;
    yield next;
  }
}
